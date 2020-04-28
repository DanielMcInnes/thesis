pragma SPARK_mode (on); 

with ocpp;
with ocpp.ChargingStationType;
with Ada.Strings; use Ada.Strings;

package body ocpp.ChargingStationType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.ChargingStationType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "serialNumber", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.serialNumber := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "model", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.model := NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "modem", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ModemType.parse(msg, msgindex, self.modem, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "vendorName", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.vendorName := NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "firmwareVersion", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.firmwareVersion := NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strmodem : NonSparkTypes.packet.Bounded_String;
   begin
      ModemType.To_Bounded_String(Self.modem, strmodem);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "serialNumber" & '"' & ": " & '"' & NonSparkTypes.ChargingStationType.strserialNumber_t.To_String(Self.serialNumber) & '"' & ": " & "," & ASCII.LF
                                                      & "    " & '"' & "model" & '"' & ": " & '"' & NonSparkTypes.ChargingStationType.strmodel_t.To_String(Self.model) & '"' & ": " & "," & ASCII.LF
                                                      & "    " & '"' & "modem" & '"' & ":" & NonSparkTypes.packet.To_String(strmodem) & "," & ASCII.LF
                                                      & "    " & '"' & "vendorName" & '"' & ": " & '"' & NonSparkTypes.ChargingStationType.strvendorName_t.To_String(Self.vendorName) & '"' & ": " & "," & ASCII.LF
                                                      & "    " & '"' & "firmwareVersion" & '"' & ": " & '"' & NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_String(Self.firmwareVersion) & '"' & ": " & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.ChargingStationType;

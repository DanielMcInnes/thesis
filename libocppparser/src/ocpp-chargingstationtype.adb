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
      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "serialNumber", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.serialNumber, valid);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "model", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.model, valid);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "modem", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      objectType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.modem, valid);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "vendorName", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.vendorName, valid);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "firmwareVersion", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.firmwareVersion, valid);

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strserialNumber : undefinedType.string_t.Bounded_string;
      strmodel : undefinedType.string_t.Bounded_string;
      strvendorName : undefinedType.string_t.Bounded_string;
      strfirmwareVersion : undefinedType.string_t.Bounded_string;
   begin
      undefinedType.ToString(Self.serialNumber, strserialNumber);
      undefinedType.ToString(Self.model, strmodel);
      undefinedType.ToString(Self.vendorName, strvendorName);
      undefinedType.ToString(Self.firmwareVersion, strfirmwareVersion);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "serialNumber" & '"' & ": " & '"' & undefinedType.string_t.To_String(strserialNumber) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "model" & '"' & ": " & '"' & undefinedType.string_t.To_String(strmodel) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "modem" & '"' & ": " & '"' & ModemType.string_t.To_String(strmodem) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "vendorName" & '"' & ": " & '"' & undefinedType.string_t.To_String(strvendorName) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "firmwareVersion" & '"' & ": " & '"' & undefinedType.string_t.To_String(strfirmwareVersion) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.[object Object];

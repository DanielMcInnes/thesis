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

   procedure Initialize(self: out ocpp.ChargingStationType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.serialNumber := ChargingStationTypeStrings.strserialNumber_t.To_Bounded_String("");
      self.model := ChargingStationTypeStrings.strmodel_t.To_Bounded_String("");
      ModemType.Initialize(self.modem);
      self.vendorName := ChargingStationTypeStrings.strvendorName_t.To_Bounded_String("");
      self.firmwareVersion := ChargingStationTypeStrings.strfirmwareVersion_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.ChargingStationType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "serialNumber", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ChargingStationTypeserialNumber"); return; end if;

      self.serialNumber := ChargingStationTypeStrings.strserialNumber_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "model", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ChargingStationTypemodel"); return; end if;

      self.model := ChargingStationTypeStrings.strmodel_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKey(msg, msgIndex, valid, "modem");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid ChargingStationTypemodem"); return; end if;

      ModemType.parse(msg, msgindex, self.modem, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid ChargingStationTypemodem"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "vendorName", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ChargingStationTypevendorName"); return; end if;

      self.vendorName := ChargingStationTypeStrings.strvendorName_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "firmwareVersion", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ChargingStationTypefirmwareVersion"); return; end if;

      self.firmwareVersion := ChargingStationTypeStrings.strfirmwareVersion_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid ChargingStationTypefirmwareVersion"); return; end if;
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
                                                      & "    " & '"' & "serialNumber" & '"' & ": " & '"' & ChargingStationTypeStrings.strserialNumber_t.To_String(Self.serialNumber) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "model" & '"' & ": " & '"' & ChargingStationTypeStrings.strmodel_t.To_String(Self.model) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "modem" & '"' & ":" & NonSparkTypes.packet.To_String(strmodem) & "," & ASCII.LF
                                                      & "    " & '"' & "vendorName" & '"' & ": " & '"' & ChargingStationTypeStrings.strvendorName_t.To_String(Self.vendorName) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "firmwareVersion" & '"' & ": " & '"' & ChargingStationTypeStrings.strfirmwareVersion_t.To_String(Self.firmwareVersion) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.ChargingStationType;

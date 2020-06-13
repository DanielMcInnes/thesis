pragma SPARK_mode (on); 

with ocpp;
with ocpp.SignedMeterValueType;
with Ada.Strings; use Ada.Strings;

package body ocpp.SignedMeterValueType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.SignedMeterValueType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.signedMeterData := SignedMeterValueTypeStrings.strsignedMeterData_t.To_Bounded_String("");
      self.signingMethod := SignedMeterValueTypeStrings.strsigningMethod_t.To_Bounded_String("");
      self.encodingMethod := SignedMeterValueTypeStrings.strencodingMethod_t.To_Bounded_String("");
      self.publicKey := SignedMeterValueTypeStrings.strpublicKey_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.SignedMeterValueType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "signedMeterData", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SignedMeterValueTypesignedMeterData"); return; end if;

      self.signedMeterData := SignedMeterValueTypeStrings.strsignedMeterData_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "signingMethod", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SignedMeterValueTypesigningMethod"); return; end if;

      self.signingMethod := SignedMeterValueTypeStrings.strsigningMethod_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "encodingMethod", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SignedMeterValueTypeencodingMethod"); return; end if;

      self.encodingMethod := SignedMeterValueTypeStrings.strencodingMethod_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "publicKey", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SignedMeterValueTypepublicKey"); return; end if;

      self.publicKey := SignedMeterValueTypeStrings.strpublicKey_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid SignedMeterValueTypepublicKey"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "signedMeterData" & '"' & ": " & '"' & SignedMeterValueTypeStrings.strsignedMeterData_t.To_String(Self.signedMeterData) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "signingMethod" & '"' & ": " & '"' & SignedMeterValueTypeStrings.strsigningMethod_t.To_String(Self.signingMethod) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "encodingMethod" & '"' & ": " & '"' & SignedMeterValueTypeStrings.strencodingMethod_t.To_String(Self.encodingMethod) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "publicKey" & '"' & ": " & '"' & SignedMeterValueTypeStrings.strpublicKey_t.To_String(Self.publicKey) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.SignedMeterValueType;

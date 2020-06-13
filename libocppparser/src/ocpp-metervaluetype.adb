pragma SPARK_mode (on); 

with ocpp;
with ocpp.MeterValueType;
with Ada.Strings; use Ada.Strings;

package body ocpp.MeterValueType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.MeterValueType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      sampledValueTypeArray.Initialize(self.sampledValue);
      self.timestamp := MeterValueTypeStrings.strtimestamp_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.MeterValueType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKey(msg, msgIndex, valid, "sampledValue");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid MeterValueTypesampledValue"); return; end if;

      sampledValueTypeArray.FromString(msg, msgindex, self.sampledValue, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid MeterValueTypesampledValue"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "timestamp", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid MeterValueTypetimestamp"); return; end if;

      self.timestamp := MeterValueTypeStrings.strtimestamp_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid MeterValueTypetimestamp"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strsampledValue: NonSparkTypes.packet.Bounded_String;
   begin
      sampledValueTypeArray.To_Bounded_String(strsampledValue, self.sampledValue);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "sampledValue" & '"' & ": " & NonSparkTypes.packet.To_String(strsampledValue) & "," & ASCII.LF
                                                      & "    " & '"' & "timestamp" & '"' & ": " & '"' & MeterValueTypeStrings.strtimestamp_t.To_String(Self.timestamp) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.MeterValueType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.SampledValueType;
with Ada.Strings; use Ada.Strings;

package body ocpp.SampledValueType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.SampledValueType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.value := -1;
      self.context := ReadingContextEnumType.Interruption_Begin;
      self.measurand := MeasurandEnumType.Current_Export;
      self.phase := PhaseEnumType.L1;
      self.location := LocationEnumType.ABody;
      SignedMeterValueType.Initialize(self.signedMeterValue);
      UnitOfMeasureType.Initialize(self.unitOfMeasure);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.SampledValueType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "value", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid SampledValueTypevalue"); return; end if;
      self.value := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "context", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SampledValueTypecontext"); return; end if;

      ocpp.ReadingContextEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.context, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid SampledValueTypecontext"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "measurand", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SampledValueTypemeasurand"); return; end if;

      ocpp.MeasurandEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.measurand, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid SampledValueTypemeasurand"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "phase", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SampledValueTypephase"); return; end if;

      ocpp.PhaseEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.phase, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid SampledValueTypephase"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "location", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid SampledValueTypelocation"); return; end if;

      ocpp.LocationEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.location, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid SampledValueTypelocation"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "signedMeterValue");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid SampledValueTypesignedMeterValue"); return; end if;

      SignedMeterValueType.parse(msg, msgindex, self.signedMeterValue, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid SampledValueTypesignedMeterValue"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "unitOfMeasure");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid SampledValueTypeunitOfMeasure"); return; end if;

      UnitOfMeasureType.parse(msg, msgindex, self.unitOfMeasure, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid SampledValueTypeunitOfMeasure"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid SampledValueTypeunitOfMeasure"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strcontext : ReadingContextEnumType.string_t.Bounded_String;
      strmeasurand : MeasurandEnumType.string_t.Bounded_String;
      strphase : PhaseEnumType.string_t.Bounded_String;
      strlocation : LocationEnumType.string_t.Bounded_String;
      strsignedMeterValue : NonSparkTypes.packet.Bounded_String;
      strunitOfMeasure : NonSparkTypes.packet.Bounded_String;
   begin
      ReadingContextEnumType.ToString(Self.context, strcontext);
      MeasurandEnumType.ToString(Self.measurand, strmeasurand);
      PhaseEnumType.ToString(Self.phase, strphase);
      LocationEnumType.ToString(Self.location, strlocation);
      SignedMeterValueType.To_Bounded_String(Self.signedMeterValue, strsignedMeterValue);
      UnitOfMeasureType.To_Bounded_String(Self.unitOfMeasure, strunitOfMeasure);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "value" & '"' & ": " & Self.value'Image & "," & ASCII.LF
                                                      & "       " & '"' & "context" & '"' & ":"  & '"' & ReadingContextEnumType.string_t.To_String(strcontext) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "measurand" & '"' & ":"  & '"' & MeasurandEnumType.string_t.To_String(strmeasurand) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "phase" & '"' & ":"  & '"' & PhaseEnumType.string_t.To_String(strphase) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "location" & '"' & ":"  & '"' & LocationEnumType.string_t.To_String(strlocation) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "signedMeterValue" & '"' & ":" & NonSparkTypes.packet.To_String(strsignedMeterValue) & "," & ASCII.LF
                                                      & "    " & '"' & "unitOfMeasure" & '"' & ":" & NonSparkTypes.packet.To_String(strunitOfMeasure) & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.SampledValueType;

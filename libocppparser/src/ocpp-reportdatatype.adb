pragma SPARK_mode (on); 

with ocpp;
with ocpp.ReportDataType;
with Ada.Strings; use Ada.Strings;

package body ocpp.ReportDataType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.ReportDataType.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.zzzArrayElementInitialized := False;
      ComponentType.Initialize(self.component);
      VariableType.Initialize(self.variable);
      variableAttributeTypeArray.Initialize(self.variableAttribute);
      VariableCharacteristicsType.Initialize(self.variableCharacteristics);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.ReportDataType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKey(msg, msgIndex, valid, "component");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid ReportDataTypecomponent"); return; end if;

      ComponentType.parse(msg, msgindex, self.component, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid ReportDataTypecomponent"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "variable");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid ReportDataTypevariable"); return; end if;

      VariableType.parse(msg, msgindex, self.variable, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid ReportDataTypevariable"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "variableAttribute");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid ReportDataTypevariableAttribute"); return; end if;

      VariableAttributeTypeArray.FromString(msg, msgindex, self.variableAttribute, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid ReportDataTypevariableAttribute"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "variableCharacteristics");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid ReportDataTypevariableCharacteristics"); return; end if;

      VariableCharacteristicsType.parse(msg, msgindex, self.variableCharacteristics, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid ReportDataTypevariableCharacteristics"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid ReportDataTypevariableCharacteristics"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strcomponent : NonSparkTypes.packet.Bounded_String;
      strvariable : NonSparkTypes.packet.Bounded_String;
      strvariableAttribute: NonSparkTypes.packet.Bounded_String;
      strvariableCharacteristics : NonSparkTypes.packet.Bounded_String;
   begin
      ComponentType.To_Bounded_String(Self.component, strcomponent);
      VariableType.To_Bounded_String(Self.variable, strvariable);
      VariableAttributeTypeArray.To_Bounded_String(strvariableAttribute, self.variableAttribute);
      VariableCharacteristicsType.To_Bounded_String(Self.variableCharacteristics, strvariableCharacteristics);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "component" & '"' & ":" & NonSparkTypes.packet.To_String(strcomponent) & "," & ASCII.LF
                                                      & "    " & '"' & "variable" & '"' & ":" & NonSparkTypes.packet.To_String(strvariable) & "," & ASCII.LF
                                                      & "    " & '"' & "variableAttribute" & '"' & ": " & NonSparkTypes.packet.To_String(strvariableAttribute) & "," & ASCII.LF
                                                      & "    " & '"' & "variableCharacteristics" & '"' & ":" & NonSparkTypes.packet.To_String(strvariableCharacteristics) & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.ReportDataType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.SetVariableDataType;
with Ada.Strings; use Ada.Strings;

package body ocpp.SetVariableDataType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.SetVariableDataType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "attributeType", dummybounded);
      ocpp.AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.attributeType, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid SetVariableDataTypeattributeType"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "attributeValue", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("338 Invalid SetVariableDataTypeattributeValue"); return; end if;
      self.attributeValue := NonSparkTypes.SetVariableDataType.strattributeValue_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "component", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("355 Invalid SetVariableDataTypecomponent"); return; end if;

      ComponentType.parse(msg, msgindex, self.component, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid SetVariableDataTypecomponent"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "variable", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("355 Invalid SetVariableDataTypevariable"); return; end if;

      VariableType.parse(msg, msgindex, self.variable, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid SetVariableDataTypevariable"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid SetVariableDataTypevariable"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strattributeType : AttributeEnumType.string_t.Bounded_String;
      strcomponent : NonSparkTypes.packet.Bounded_String;
      strvariable : NonSparkTypes.packet.Bounded_String;
   begin
      AttributeEnumType.ToString(Self.attributeType, strattributeType);
      ComponentType.To_Bounded_String(Self.component, strcomponent);
      VariableType.To_Bounded_String(Self.variable, strvariable);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "attributeType" & '"' & ":"  & '"' & AttributeEnumType.string_t.To_String(strattributeType) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "attributeValue" & '"' & ": " & '"' & NonSparkTypes.SetVariableDataType.strattributeValue_t.To_String(Self.attributeValue) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "component" & '"' & ":" & NonSparkTypes.packet.To_String(strcomponent) & "," & ASCII.LF
                                                      & "    " & '"' & "variable" & '"' & ":" & NonSparkTypes.packet.To_String(strvariable) & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.SetVariableDataType;

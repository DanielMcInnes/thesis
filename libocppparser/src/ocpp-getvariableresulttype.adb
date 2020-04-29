pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetVariableResultType;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariableResultType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.GetVariableResultType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
      tempPositive: Integer;
   begin
      put("GetVariableResultType: parse: msgindex :"); put_line(msgindex'Image);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "attributeStatus", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("failed to find attributeStatus"); return; end if;
      
      ocpp.GetVariableStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.attributeStatus, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid GetVariableResultTypeattributeStatus"); return; end if;
      NonSparkTypes.put_line("found attributeStatus");
      NonSparkTypes.put_line("found comma");

      
      

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "attributeType", dummybounded);
      ocpp.AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.attributeType, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid GetVariableResultTypeattributeType"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "attributeValue", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("338 Invalid GetVariableResultTypeattributeValue"); return; end if;
      self.attributeValue := NonSparkTypes.GetVariableResultType.strattributeValue_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKey(msg, msgIndex, valid, "component");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid GetVariableResultTypecomponent"); return; end if;

      ComponentType.parse(msg, msgindex, self.component, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid GetVariableResultTypecomponent"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "variable");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid GetVariableResultTypevariable"); return; end if;

      VariableType.parse(msg, msgindex, self.variable, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid GetVariableResultTypevariable"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GetVariableResultTypevariable"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strattributeStatus : GetVariableStatusEnumType.string_t.Bounded_String;
      strattributeType : AttributeEnumType.string_t.Bounded_String;
      strcomponent : NonSparkTypes.packet.Bounded_String;
      strvariable : NonSparkTypes.packet.Bounded_String;
   begin
      GetVariableStatusEnumType.ToString(Self.attributeStatus, strattributeStatus);
      AttributeEnumType.ToString(Self.attributeType, strattributeType);
      ComponentType.To_Bounded_String(Self.component, strcomponent);
      VariableType.To_Bounded_String(Self.variable, strvariable);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "attributeStatus" & '"' & ":"  & '"' & GetVariableStatusEnumType.string_t.To_String(strattributeStatus) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "attributeType" & '"' & ":"  & '"' & AttributeEnumType.string_t.To_String(strattributeType) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "attributeValue" & '"' & ": " & '"' & NonSparkTypes.GetVariableResultType.strattributeValue_t.To_String(Self.attributeValue) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "component" & '"' & ":" & NonSparkTypes.packet.To_String(strcomponent) & "," & ASCII.LF
                                                      & "    " & '"' & "variable" & '"' & ":" & NonSparkTypes.packet.To_String(strvariable) & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.GetVariableResultType;

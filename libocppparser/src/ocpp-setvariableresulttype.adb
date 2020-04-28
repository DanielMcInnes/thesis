pragma SPARK_mode (on); 

with ocpp;
with ocpp.SetVariableResultType;
with Ada.Strings; use Ada.Strings;

package body ocpp.SetVariableResultType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.SetVariableResultType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      ocpp.AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.attributeType, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.SetVariableStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.attributeStatus, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "component", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ComponentType.parse(msg, msgindex, self.component, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "variable", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      VariableType.parse(msg, msgindex, self.variable, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strattributeType : AttributeEnumType.string_t.Bounded_String;
      strattributeStatus : SetVariableStatusEnumType.string_t.Bounded_String;
      strcomponent : NonSparkTypes.packet.Bounded_String;
      strvariable : NonSparkTypes.packet.Bounded_String;
   begin
      AttributeEnumType.ToString(Self.attributeType, strattributeType);
      SetVariableStatusEnumType.ToString(Self.attributeStatus, strattributeStatus);
      ComponentType.To_Bounded_String(Self.component, strcomponent);
      VariableType.To_Bounded_String(Self.variable, strvariable);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "attributeType" & '"' & ":"  & '"' & AttributeEnumType.string_t.To_String(strattributeType) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "attributeStatus" & '"' & ":"  & '"' & SetVariableStatusEnumType.string_t.To_String(strattributeStatus) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & NonSparkTypes.packet.To_String(strcomponent) & '"' & ": "
 & "," & ASCII.LF
                                                      & "    " & '"' & NonSparkTypes.packet.To_String(strvariable) & '"' & ": "
 & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.SetVariableResultType;

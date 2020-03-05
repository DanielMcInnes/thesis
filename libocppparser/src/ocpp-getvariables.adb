pragma SPARK_Mode (On);

with utils;
with ComponentType;
with NonSparkTypes;

package body ocpp.GetVariables is
   procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );
   
   package body Request is

      procedure To_Bounded_String(Self: in ocpp.getvariables.Request.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String)
      is
         use NonSparkTypes;
         use NonSparkTypes.AttributeEnumType;
         use NonSparkTypes.AttributeEnumType.string_t;
         attributeStr : string_t.Bounded_String;

      begin
         ToString(Self.getVariableData.attributeType, attributeStr);
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[2," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "getVariableData" & '"' & ": {" & ASCII.LF
                                                           & "   " & '"' & "attributeType" & '"' & ":" & '"' & string_t.To_String(attributeStr) & '"' & ASCII.LF
                                                           & "      " & '"' & "component"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & ComponentType.name.To_String(Self.getVariableData.component.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & ComponentType.instance.To_String(Self.getVariableData.component.instance) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "evse" & '"' & ": {" & ASCII.LF
                                                           & "            " & '"' & "id" & '"' & " : " & Integer'Image(Self.getVariableData.component.evse.id) & ASCII.LF
                                                           & "            " & '"' & "connectorId" & '"' & " : " & Integer'Image(Self.getVariableData.component.evse.connectorId) & ASCII.LF
                                                           & "         }" & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "      " & '"' & "variable"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.name.To_String(Self.getVariableData.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.instance.To_String(Self.getVariableData.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]",Drop => Ada.Strings.Right);
      end To_Bounded_String;
   end Request;   

end ocpp.getvariables;

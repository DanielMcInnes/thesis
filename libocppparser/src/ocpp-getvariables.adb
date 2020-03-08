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
         use ocpp.AttributeEnumType;
         use ocpp.AttributeEnumType.string_t;
         attributeStr : ocpp.AttributeEnumType.string_t.Bounded_String;

      begin
         ToString(Self.getVariableData.attributeType, attributeStr);
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[2," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "getVariableData" & '"' & ": {" & ASCII.LF
                                                           & "   " & '"' & "attributeType" & '"' & ":" & '"' & ocpp.AttributeEnumType.string_t.To_String(attributeStr) & '"' & ASCII.LF
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
   
   package body Response
   is
      
      package body GetVariableResultType
      is
         
         
      end GetVariableResultType;
      
      procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                      msgindex: in out Integer;
                      response: in out ocpp.GetVariables.Response.Class;
                      valid: out Boolean
                     )
      is
         dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
         tempmsgindex: Integer;
         use ocpp.GetVariables.Response.GetVariableResultType;
      begin
         if (response.messagetypeid /= 3)
         then
            valid := false;
            NonSparkTypes.put("GetVariables: parse: error 182");
            NonSparkTypes.put(response.messagetypeid'Image);
            return;              
         end if;
         pragma assert(response.messagetypeid = 3);
         
         findQuotedKeyQuotedValue(msg, msgindex, valid, "attributeStatus", dummybounded);
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 206: invalid 'attributeStatus'");
            return;
         end if;
         
         FromString(NonSparkTypes.packet.To_String(dummybounded), response.getVariableResult.attributeStatus, valid);
         if (valid = false) then return; end if;
         
         NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));


         tempmsgindex := msgindex;
         NonSparkTypes.put_line("parse: looking for optional 'attributeType' key: ");
         findQuotedKeyQuotedValue(msg, tempmsgindex, valid, "attributeType", dummybounded);
         if (valid = true) then
            msgindex := tempmsgindex;
            NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
            AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), response.getVariableResult.attributeType, valid);
            if (valid = false) then
               NonSparkTypes.put("parse: ERROR 222: invalid 'attributeType' value");
               return;
            end if;
         else
            NonSparkTypes.put_line("parse: not found");
            response.getVariableResult.attributeType := ocpp.AttributeEnumType.Actual; -- default to 'Actual' if unspecified
         end if;


         NonSparkTypes.put_line("parse: looking for optional attributeValue...");
         tempmsgindex := msgindex;
         findQuotedKeyQuotedValue(msg, tempmsgindex, valid, "attributeValue", dummybounded);
         if (valid = true) then
            msgindex := tempmsgindex;
            NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
            
            
            
            
            
            
            
            attributeValue_t.FromString(NonSparkTypes.packet.To_String(dummybounded), response.getVariableResult.attributeValue);
            if (valid = false) then
               NonSparkTypes.put("parse: ERROR 222: invalid 'attributeType' value");
               return;
            end if;
         else
            NonSparkTypes.put_line("parse: not found");
            response.getVariableResult.attributeType := ocpp.AttributeEnumType.Actual; -- default to 'Actual' if unspecified
         end if;
         

         
         
         
         NonSparkTypes.put_line("parse: looking for component...");
         findString(msg, msgindex, valid, "component");
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 202: invalid component");
            return;
         end if;
         
         findQuotedKeyQuotedValue(msg, msgindex, valid, "name", dummybounded);
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 202: invalid component");
            return;
         end if;
         response.getVariableResult.component.name := ComponentType.name.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Ada.Strings.Right);
       
         -- find optional items
         tempmsgindex := msgindex;
         findQuotedKeyQuotedValue(msg, tempmsgindex, valid, "instance", dummybounded);
         if (valid = true) then
            msgindex := tempmsgindex;
            if (NonSparkTypes.packet.Length(dummybounded) < 1)
            then
               valid := false;
               return;
            end if;
            response.getVariableResult.component.instance := ComponentType.instance.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Ada.Strings.Right);
         end if;
         
         tempmsgindex := msgindex;
         findString(msg, tempmsgindex, valid, "evse");
         if (valid = true) then
            msgindex := tempmsgindex;
            findQuotedKeyUnquotedValue(msg, msgindex, valid, "id", response.getVariableResult.component.evse.id);
            if (valid = false) then
               NonSparkTypes.put("parse: ERROR 229: invalid component");
               return;
            end if;
            
            tempmsgindex := msgindex;
            findQuotedKeyUnquotedValue(msg, tempmsgindex, valid, "connectorId", response.getVariableResult.component.evse.connectorId);
            if (valid = true) then
               msgindex := tempmsgindex;
               if (NonSparkTypes.packet.Length(dummybounded) < 1)
               then
                  return;
               end if;
               tempmsgindex := 1;
               ocpp.findnextinteger(dummybounded, tempmsgindex, response.getVariableResult.component.evse.connectorId, valid);
               NonSparkTypes.put(tempmsgindex'Image);
               if (valid = false) 
               then
                  NonSparkTypes.put_line("parse: ERROR 276");
                  return;
               end if;
            end if;
         end if;
         
         ocpp.move_index_past_token(msg, '}', msgindex, tempmsgindex); 
         if (tempmsgindex = 0) 
         then 
            NonSparkTypes.put_line("parse: ERROR 284");
            valid := false;
            return; 
         end if;
         
         ocpp.VariableType.parse(msg, msgindex, response.getVariableResult.variable, valid);
         if (valid = false) 
         then 
            NonSparkTypes.put_line("parse: ERROR 293");
            return; 
         end if;
         NonSparkTypes.put_line("parse: 296");
         

         if (msgindex < 1) then valid := false; return; end if;
         ocpp.move_index_past_token(msg, '}', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;
         NonSparkTypes.put_line("parse: 305");

         valid := true;
         
         
      end parse;

      procedure To_Bounded_String(Self: in ocpp.getvariables.Response.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String)
      is
         use NonSparkTypes;
         use ocpp.AttributeEnumType;
         use ocpp.AttributeEnumType.string_t;

         use ocpp.GetVariableStatusEnumType;
         use ocpp.GetVariableStatusEnumType.string_t;
         
         use NonSparkTypes.attributeValue_t;
         
         attributeStatusStr : ocpp.GetVariableStatusEnumType.string_t.Bounded_String;
         attributeTypeStr : ocpp.AttributeEnumType.string_t.Bounded_String;
         
      begin
         ToString(Self.getVariableResult.attributeStatus, attributeStatusStr);
         ToString(Self.getVariableResult.attributeType, attributeTypeStr);
         
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[3," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "getVariableResult" & '"' & ": {" & ASCII.LF
                                                           & "      " & '"' & "attributeStatus" & '"' & ":" & '"' & GetVariableStatusEnumType.string_t.To_String(attributeStatusStr) & '"' & ASCII.LF
                                                           & "      " & '"' & "attributeType" & '"' & ":" & '"' & AttributeEnumType.string_t.To_String(attributeTypeStr) & '"' & ASCII.LF
                                                           & "      " & '"' & "attributeValue" & '"' & ":" & '"' & attributeValue_t.string_t.To_String(self.getVariableResult.attributeValue) & '"' & ASCII.LF
                                                           & "         " & '"' & "component"  & '"' & ": {" & ASCII.LF
                                                           & "            " & '"' & "name" & '"' & ":" & " : " & '"' & ComponentType.name.To_String(Self.getVariableResult.component.name) & '"' & "," & ASCII.LF
                                                           & "            " & '"' & "instance" & '"' & ":" & " : " & '"' & ComponentType.instance.To_String(Self.getVariableResult.component.instance) & '"' & "," & ASCII.LF
                                                           & "            " & '"' & "evse" & '"' & ": {" & ASCII.LF
                                                           & "               " & '"' & "id" & '"' & " : " & Integer'Image(Self.getVariableResult.component.evse.id) & ASCII.LF
                                                           & "               " & '"' & "connectorId" & '"' & " : " & Integer'Image(Self.getVariableResult.component.evse.connectorId) & ASCII.LF
                                                           & "            }" & ASCII.LF
                                                           & "         }" & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "      " & '"' & "variable"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.name.To_String(Self.getVariableResult.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.instance.To_String(Self.getVariableResult.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]",Drop => Ada.Strings.Right);
      end To_Bounded_String;
      
   end Response;
   

end ocpp.getvariables;

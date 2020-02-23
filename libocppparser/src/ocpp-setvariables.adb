pragma SPARK_Mode (On);

with ocpp.SetVariables;
with utils;
with ComponentType;
with NonSparkTypes;

package body ocpp.SetVariables is
   procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );
   
   procedure DefaultInitialize(Self : out ocpp.SetVariables.Request.Class) 
   is
   begin
      self.messagetypeid := 2;
      self.messageid := messageid_t.To_Bounded_String("19223201");
      self.action := action;

      self.setVariableData.attributeType := NonSparkTypes.AttributeEnumType.Invalid;
      self.setVariableData.attributeValue := NonSparkTypes.setvariables_t.request.attributeValue_t.To_Bounded_String("");
      
      self.setVariableData.component.name := ComponentType.name.To_Bounded_String("");
      self.setVariableData.component.instance := ComponentType.instance.To_Bounded_String("");

      self.setVariableData.component.evse.id := 0;
      self.setVariableData.component.evse.connectorId := 0;
      
      self.setVariableData.variable.name := NonSparkTypes.VariableType_t.name.To_Bounded_String("");
      self.setVariableData.variable.instance := NonSparkTypes.VariableType_t.instance.To_Bounded_String("");
      
      
   end DefaultInitialize;
   
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   response: in ocpp.SetVariables.Response.Class;
                   valid: out Boolean
                  )
   is
   begin
      valid := false;
      
      if response.messagetypeid /= 3 then
         NonSparkTypes.put_line("parse: Error: 142"); 
         return;
      end if;
      
      if (msgindex >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;
      if (msgindex < 1)
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;      

      if (NonSparkTypes.messageid_t.Length(response.messageid) <= 0) then return; end if;
      
      valid := true;
   end parse;

   --1.59. SetVariables
   --1.59.1. SetVariablesRequest

   -- FieldName           Field Type  
   -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
   -- setVariableData     SetVariableDataType
   
   --[2,
   --"19223202",
   --"SetVariables",
   --{
   --   "setVariableData": {
   --      "attributeType":"Actual",                -- AttributeEnumType. Actual, Target, MinSet, MaxSet
   --      "attributeValue":"p@ssw0rd",             -- string[0..1000]
   --      "component": {                           -- ComponentType. 1..1 Required. The component for which the variable data is set.
   --          "name" : "evse",                          -- string[0..50], required
   --          "instance" : "0",                      -- string[0..50], optional
   --          "evse" : {                            -- evseType, optional
   --              "id" : 0,                      -- integer, Required. EVSE Identifier. When 0, the ID references the Charging Station as a whole.
   --              "connectorId" : 0                 -- integer. Optional. An id to designate a specific connector (on an EVSE) by connector index number.
   --          }
   --      }
   --      "variable":{
   --         "name": "loginPassword"
   --         "instance": "0"
   --      }
   --   }
   --}
   --]

   --   type Request is new call with record
   --      reason: NonSparkTypes.BootReasonEnumType.Bounded_String := NonSparkTypes.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
   --      chargingStation: ChargingStation_t;
   --   end record;
   
   package body Request is

      procedure To_Bounded_String(Self: in ocpp.setvariables.Request.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String)
      is
         use NonSparkTypes;
         use NonSparkTypes.AttributeEnumType;
         use NonSparkTypes.AttributeEnumType.string_t;
         attributeStr : string_t.Bounded_String;

      begin
         ToString(Self.setVariableData.attributeType, attributeStr);
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[2," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "setVariableData" & '"' & ": {" & ASCII.LF
                                                           & "   " & '"' & "attributeType" & '"' & ":" & '"' & string_t.To_String(attributeStr) & '"' & ASCII.LF
                                                           & "      " & '"' & "attributeValue"  & '"' & ":" & '"' & NonSparkTypes.setvariables_t.request.attributeValue_t.To_String(Self.setVariableData.attributeValue) & '"' & "," & ASCII.LF
                                                           & "      " & '"' & "component"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & ComponentType.name.To_String(Self.setVariableData.component.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & ComponentType.instance.To_String(Self.setVariableData.component.instance) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "evse" & '"' & ": {" & ASCII.LF
                                                           & "            " & '"' & "id" & '"' & " : " & Integer'Image(Self.setVariableData.component.evse.id) & ASCII.LF
                                                           & "            " & '"' & "connectorId" & '"' & " : " & Integer'Image(Self.setVariableData.component.evse.connectorId) & ASCII.LF
                                                           & "         }" & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "      " & '"' & "variable"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.name.To_String(Self.setVariableData.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.instance.To_String(Self.setVariableData.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]",Drop => Ada.Strings.Right);
      end To_Bounded_String;
   end Request;

   package body Response is
      procedure To_Bounded_String(Self: in ocpp.setvariables.Response.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String)
      is
      begin
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[3," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "setVariableResult" & '"' & ": {" & ASCII.LF
                                                           & "      " & '"' & "attributeType" & '"' & ":" & '"' & Self.setVariableResult.attributeType'Image & '"' & ASCII.LF
                                                           & "      " & '"' & "attributeStatus" & '"' & ":" & '"' & Self.setVariableResult.attributeStatus'Image & '"' & ASCII.LF
                                                           & "      " & '"' & "component"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & ComponentType.name.To_String(Self.setVariableResult.component.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & ComponentType.instance.To_String(Self.setVariableResult.component.instance) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "evse" & '"' & ": {" & ASCII.LF
                                                           & "            " & '"' & "id" & '"' & " : " & Integer'Image(Self.setVariableResult.component.evse.id) & ASCII.LF
                                                           & "            " & '"' & "connectorId" & '"' & " : " & Integer'Image(Self.setVariableResult.component.evse.connectorId) & ASCII.LF
                                                           & "         }" & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "      " & '"' & "variable"  & '"' & ": {" & ASCII.LF
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.name.To_String(Self.setVariableResult.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & NonSparkTypes.VariableType_t.instance.To_String(Self.setVariableResult.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]",Drop => Ada.Strings.Right);
      end To_Bounded_String;

      procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                      msgindex: in out Integer;
                      response: in out ocpp.SetVariables.Response.Class;
                      valid: out Boolean
                     )
      is
         dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
         tempmsgindex: Integer;
         use ocpp.SetVariables.Response.SetVariableResultType;
      begin
         if (response.messagetypeid /= 3)
         then
            valid := false;
            NonSparkTypes.put("SetVariables: parse: error 182");
            NonSparkTypes.put(response.messagetypeid'Image);
            return;              
         end if;
         pragma assert(response.messagetypeid = 3);
         
         tempmsgindex := msgindex;
         
         NonSparkTypes.put_line("parse: looking for optional 'attributeType' key: ");
         findQuotedKeyQuotedValue(msg, tempmsgindex, valid, "attributeType", dummybounded);
         if (valid = true) then
            msgindex := tempmsgindex;
            NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
            AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), response.setVariableResult.attributeType, valid);
            if (valid = false) then
               NonSparkTypes.put("parse: ERROR 222: invalid 'attributeType' value");
               return;
            end if;
         else
            response.setVariableResult.attributeType := NonSparkTypes.AttributeEnumType.Actual; -- default to 'Actual' if unspecified
         end if;

         if (response.setVariableResult.attributeType = AttributeEnumType.Invalid)
         then
            valid := false;
            return;
         end if;
         pragma assert(response.setVariableResult.attributeType /= AttributeEnumType.Invalid);

         findQuotedKeyQuotedValue(msg, msgindex, valid, "attributeStatus", dummybounded);
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 206: invalid 'attributeStatus'");
            return;
         end if;
         
         FromString(NonSparkTypes.packet.To_String(dummybounded), response.setVariableResult.attributeStatus);
         
         if (response.setVariableResult.attributeStatus = Invalid)
         then
            NonSparkTypes.put("parse: ERROR 215: invalid 'attributeStatus' value");
            valid := false;
            return;
         end if;
         NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));

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
         response.setVariableResult.component.name := ComponentType.name.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded) ,Drop => Ada.Strings.Right);
       
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
            response.setVariableResult.component.instance := ComponentType.instance.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Ada.Strings.Right);
         end if;
         
         tempmsgindex := msgindex;
         findString(msg, tempmsgindex, valid, "evse");
         if (valid = true) then
            msgindex := tempmsgindex;
            findQuotedKeyUnquotedValue(msg, msgindex, valid, "id", response.setVariableResult.component.evse.id);
            if (valid = false) then
               NonSparkTypes.put("parse: ERROR 229: invalid component");
               return;
            end if;
            
            tempmsgindex := msgindex;
            findQuotedKeyUnquotedValue(msg, tempmsgindex, valid, "connectorId", response.setVariableResult.component.evse.connectorId);
            if (valid = true) then
               msgindex := tempmsgindex;
               if (NonSparkTypes.packet.Length(dummybounded) < 1)
               then
                  return;
               end if;
               tempmsgindex := 1;
               ocpp.findnextinteger(dummybounded, tempmsgindex, response.setVariableResult.component.evse.connectorId, valid);
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
         
         ocpp.VariableType.parse(msg, msgindex, response.setVariableResult.variable, valid);
         if (valid = false) 
         then 
            NonSparkTypes.put_line("parse: ERROR 293");
            return; 
         end if;
         NonSparkTypes.put_line("parse: 296");
         

         if (msgindex < 1) then valid := false; return; end if;
         ocpp.move_index_past_token(msg, '}', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;
         NonSparkTypes.put_line("parse: 305");

         --[3,
         --"19223202",
         --{
         --   "setVariableResult": {
         --      "attributeType":"ACTUAL"
         --      "attributeStatus":"ACCEPTED"
         --      "component": {
         --         "name": : "",
         --         "instance": : "",
         --         "evse": {
         --            "id" :  0
         --            "connectorId" :  0
         --         }
         --      }
         --      "variable": {
         --         "name": : "loginPassword",
         --         "instance": : "0",
         --      }
         --   }
         --]

                                                                                            
         
         
         valid := true;
         
         
      end parse;
      
      package body SetVariableResultType
      is
         procedure FromString(str : in String;
                              attribute : out SetVariableStatusEnumType)
         is
         begin
            --         type SetVariableStatusEnumType is (
            --                                            Invalid,
            --                                            Accepted,--Variable successfully set.
            --                                            Rejected,--Request is rejected.
            --                                            InvalidValue,--Value has invalid format for the variable.
            --                                            UnknownComponent,--Component is not known.
            --                                            UnknownVariable,--Variable is not known.
            --                                            NotSupportedAttributeType,--The AttributeType is not supported.
            ----                                            OutOfRange,--Value is out of range defined in VariableCharacteristics.
            --                                            RebootRequired--A reboot is required.
            --                                           );
            
            
            
            if (NonSparkTypes.Uncased_Equals(str, Accepted'Image)) then
               attribute := Accepted;
            elsif (NonSparkTypes.Uncased_Equals(str, Rejected'Image)) then
               attribute := Rejected;
            elsif (NonSparkTypes.Uncased_Equals(str, InvalidValue'Image)) then
               attribute := InvalidValue;
            elsif (NonSparkTypes.Uncased_Equals(str, UnknownComponent'Image)) then
               attribute := UnknownComponent;
            elsif (NonSparkTypes.Uncased_Equals(str, UnknownVariable'Image)) then
               attribute := UnknownVariable;
            elsif (NonSparkTypes.Uncased_Equals(str, NotSupportedAttributeType'Image)) then
               attribute := NotSupportedAttributeType;
            elsif (NonSparkTypes.Uncased_Equals(str, OutOfRange'Image)) then
               attribute := OutOfRange;
            elsif (NonSparkTypes.Uncased_Equals(str, RebootRequired'Image)) then
               attribute := RebootRequired;
            else
               attribute := Invalid;
               return;
            end if;
         end FromString;
         
         
      end SetVariableResultType;
      
   end Response;
   
   

end ocpp.setvariables;

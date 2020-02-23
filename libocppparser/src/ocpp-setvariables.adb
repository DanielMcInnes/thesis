with ocpp.SetVariables;
with utils;
with ComponentType;

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
   end DefaultInitialize;
   
   procedure DefaultInitialize(Self : out ocpp.SetVariables.Request.Class;
                               messageTypeId : Integer;
                               messageId : NonSparkTypes.messageid_t.Bounded_String;
                               action : NonSparkTypes.action_t.Bounded_String
                              )
   is
   begin
      self.messagetypeid := messageTypeId;
      self.messageid := messageId;
      self.action := action;
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
      begin
         retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                           & "[2," & ASCII.LF
                                                           & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                           & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                           & "{" & ASCII.LF
                                                           & "   " & '"' & "setVariableData" & '"' & ": {" & ASCII.LF
                                                           & "   " & '"' & "attributeType" & '"' & ":" & '"' & Self.setVariableData.attributeType'Image & '"' & ASCII.LF
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
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & VariableType.name.To_String(Self.setVariableData.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & VariableType.instance.To_String(Self.setVariableData.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]");
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
                                                           & "         " & '"' & "name" & '"' & ":" & " : " & '"' & VariableType.name.To_String(Self.setVariableResult.variable.name) & '"' & "," & ASCII.LF
                                                           & "         " & '"' & "instance" & '"' & ":" & " : " & '"' & VariableType.instance.To_String(Self.setVariableResult.variable.instance) & '"' & "," & ASCII.LF
                                                           & "      }" & ASCII.LF
                                                           & "   }" & ASCII.LF
                                                           & "]");
      end To_Bounded_String;
      procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                      msgindex: in out Integer;
                      response: in out ocpp.SetVariables.Response.Class;
                      valid: out Boolean
                     )
      is
         dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
         use ocpp.SetVariables.Response.SetVariableResultType;
      begin
         valid := false;
         NonSparkTypes.put_line("blah"); 
         
         NonSparkTypes.put("parse: looking for 'attributeType' key: ");
         findKeyValue(msg, msgindex, valid, "attributeType", dummybounded);
         if (valid = false) then 
            NonSparkTypes.put("parse: ERROR: looking for 'attributeType' key: ");
            return; 
         end if;
         NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
         ocpp.AttributeEnumType.StringToAttributeEnumType(NonSparkTypes.packet.To_String(dummybounded), response.setVariableResult.attributeType, valid);
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 222: invalid 'attributeType' value");
            return;
         end if;

         findKeyValue(msg, msgindex, valid, "attributeStatus", dummybounded);
         if (valid = false) then
            NonSparkTypes.put("parse: ERROR 206: invalid 'attributeStatus'");
            return;
         end if;
         
         StringToSetVariableStatusEnumType(NonSparkTypes.packet.To_String(dummybounded), 
                                           response.setVariableResult.attributeStatus);
         
         if (response.setVariableResult.attributeStatus = Invalid)
         then
            NonSparkTypes.put("parse: ERROR 215: invalid 'attributeStatus' value");
            valid := false;
            return;
         end if;
         NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
         
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

                                                                                            
         
         
         
         
      end parse;
      
      package body SetVariableResultType
      is
         procedure StringToSetVariableStatusEnumType(str : in String;
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
         end StringToSetVariableStatusEnumType;
         
         
      end SetVariableResultType;
      
   end Response;
   
   

end ocpp.setvariables;

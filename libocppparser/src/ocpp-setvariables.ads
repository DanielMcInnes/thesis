pragma SPARK_Mode (On);

--with Ada.Strings; use Ada.Strings;
--with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.action_t;
with ComponentType;
with EVSEType;
with VariableType;

package ocpp.setvariables is
   action : constant action_t.Bounded_String := action_t.To_Bounded_String("SetVariables");
   
   
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
   --      "attributeValue":"SingleSocketCharger",   -- string[0..1000]
   --      "component": {                            -- ComponentType. 1..1 Required. The component for which the variable data is set.
   --          "name" : "",                          -- string[0..50], required
   --          "instance" : "",                      -- string[0..50], optional
   --          "evse" : {                            -- evseType, optional
   --              "id" : 1234,                      -- integer, Required. EVSE Identifier. When 0, the ID references the Charging Station as a whole.
   --              "connectorId" : 1                 -- integer. Optional. An id to designate a specific connector (on an EVSE) by connector index number.
   --          }
   --      }
   --      "modem":{
   --         "iccid": "01234567890123456789"
   --         "imsi": "01234567890123456789"
   --   }
   --}
   --]

   --   type Request is new call with record
   --      reason: NonSparkTypes.BootReasonEnumType.Bounded_String := NonSparkTypes.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
   --      chargingStation: ChargingStation_t;
   --   end record;
   
   package Request is
      package DataType is 
         --SetVariableDataType is used by: SetVariablesRequest
         package attributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 1000);
      
         type Class is tagged record
            attributeType: AttributeEnumType;
            attributeValue: attributeValue_t.Bounded_String;
            component: ComponentType.Class;
            variable: VariableType.Class;
         end record;
      
      end DataType;

      type Class is new call with record
         setVariableData: ocpp.setvariables.Request.DataType.Class;      
      end record;
      
      
   end Request;
   

   type Response is new callresult with record
      currentTime: NonSparkTypes.bootnotification_t.response.currentTime.Bounded_String := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
   end record;
   
   procedure DefaultInitialize(Self : out ocpp.setvariables.Request.Class);
   procedure DefaultInitialize(Self : out ocpp.setvariables.Request.Class;
                               messageTypeId : Integer;
                               messageId : NonSparkTypes.messageid_t.Bounded_String;
                               action : NonSparkTypes.action_t.Bounded_String
                              );

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   response: in ocpp.setvariables.Response;
                   valid: out Boolean
                  )
     with
       Global => null,
       Depends => (
                     valid => (msg, msgindex, response)
                  ),
       post => (if valid = true then
                  (response.messagetypeid = 3) and
                  (NonSparkTypes.messageid_t.Length(response.messageid) > 0)
               );
   
   --   procedure To_Bounded_String(Self: in ocpp.setvariables.Request;
   --                               retval: out NonSparkTypes.packet.Bounded_String);

   
end ocpp.setvariables;

pragma SPARK_Mode (On);

--with Ada.Strings; use Ada.Strings;
--with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ComponentType;
with EVSEType;
with ocpp.VariableType;

package ocpp.SetVariables is
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
         type Class is tagged record
            attributeType: ocpp.AttributeEnumType.T; -- 0..1 Optional. Type of attribute: Actual, Target, MinSet, MaxSet. Default is Actual when omitted.
            attributeValue: NonSparkTypes.attributeValue_t.string_t.Bounded_String;
            component: ComponentType.Class; -- 1..1 Required. The component for which result is returned.
            variable: VariableType.Class; -- 1..1 Required. The variable for which the result is returned.
         end record;
      
      end DataType;

      type Class is new call with record
         setVariableData: ocpp.SetVariables.Request.DataType.Class;      
      end record;

      procedure To_Bounded_String(Self: in ocpp.setvariables.Request.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String);
      
   end Request;
   

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
   package Response
   is
      -- GetVariableResultType is used by: GetVariablesResponse
      action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("setVariableResult");
      package SetVariableResultType is
         -- SetVariableStatusEnumType is used by: setVariables:SetVariablesResponse.SetVariableResultType
         type SetVariableStatusEnumType is (
                                            Invalid,
                                            Accepted,--Variable successfully set.
                                            Rejected,--Request is rejected.
                                            InvalidValue,--Value has invalid format for the variable.
                                            UnknownComponent,--Component is not known.
                                            UnknownVariable,--Variable is not known.
                                            NotSupportedAttributeType,--The AttributeType is not supported.
                                            OutOfRange,--Value is out of range defined in VariableCharacteristics.
                                            RebootRequired--A reboot is required.
                                           );

         procedure FromString(str : in String;
                              attribute : out SetVariableStatusEnumType);
         type Class is tagged record
            attributeType: AttributeEnumType.T; -- 0..1 Optional. Type of attribute: Actual, Target, MinSet, MaxSet. Default is Actual when omitted.
            attributeStatus: SetVariableStatusEnumType; -- 1..1 Required. Result status of setting the variable.
            component: ComponentType.Class; -- 1..1 Required. The component for which result is returned.
            variable: VariableType.Class; -- 1..1 Required. The variable for which the result is returned.
         end record;
      end SetVariableResultType;
      
      type Class is new callresult with record
         setVariableResult: SetVariableResultType.Class;
      end record;

      use SetVariableResultType;
      procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                      msgindex: in out Integer;
                      response: in out ocpp.SetVariables.Response.Class;
                      valid: out Boolean
                     )
        with
          Global => null,
          Depends => (
                      msgindex => (msg, msgindex, response),
                      response => (msg, msgindex, response),
                      valid => (msg, msgindex, response)
                     ),
          post => (if valid = true then
                     (
                      (response.messagetypeid = 3) and
                      (response.setVariableResult.attributeType /= ocpp.AttributeEnumType.Invalid) and
                      (response.setVariableResult.attributeStatus /= SetVariableResultType.Invalid)
                     )
                  );

      procedure To_Bounded_String(Self: in ocpp.setvariables.Response.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String);
      
   end Response;
   
   procedure DefaultInitialize(Self : out ocpp.setvariables.Request.Class);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   response: in ocpp.setvariables.Response.Class;
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
   
   --      procedure To_Bounded_String(Self: in ocpp.setvariables.Request.Class;
   --                                  retval: out NonSparkTypes.packet.Bounded_String);

   
end ocpp.setvariables;

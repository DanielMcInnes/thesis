pragma SPARK_Mode (On);

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.action_t; use NonSparkTypes.AttributeEnumType; use NonSparkTypes.GetVariableStatusEnumType;
with ComponentType;
with EVSEType;
with ocpp.VariableType;


package ocpp.GetVariables is
   action : constant action_t.Bounded_String := action_t.To_Bounded_String("SetVariables");
   
   package Request is
      package DataType is 
         --SetVariableDataType is used by: SetVariablesRequest
         type Class is tagged record
            attributeType: NonSparkTypes.AttributeEnumType.T; -- 0..1 Optional. Type of attribute: Actual, Target, MinSet, MaxSet. Default is Actual when omitted.
            component: ComponentType.Class; -- 1..1 Required. The component for which result is returned.
            variable: VariableType.Class; -- 1..1 Required. The variable for which the result is returned.
         end record;      
      end DataType;

      type Class is new call with record
         getVariableData: ocpp.GetVariables.Request.DataType.Class;      
      end record;

      procedure To_Bounded_String(Self: in ocpp.getvariables.Request.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String);
      
   end Request;
   
   package Response is
      action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("getVariableResult");
      package GetVariableResultType is -- GetVariableResultType is used by: GetVariablesResponse
         type Class is tagged record
            attributeStatus: NonSparkTypes.GetVariableStatusEnumType.T; -- 1..1 Required. Result status of getting the variable.
            attributeType: NonSparkTypes.AttributeEnumType.T; -- 0..1 Optional. Type of attribute: Actual, Target, MinSet, MaxSet. Default is Actual when omitted.
            attributeValue: NonSparkTypes.attributeValue_t.string_t.Bounded_String; -- 0..1 Optional. Value of requested attribute type of component-variable. 
                                                                           -- This field can only be empty when the given status is NOT accepted.
                                                                           --The Configuration Variable ValueSize can be used to limit the VariableCharacteristicsType.ValueList and all
                                                                           --AttributeValue fields. The max size of these values will always remain equal. The default max size is set to 1000.
            
            component: ComponentType.Class; -- 1..1 Required. The component for which result is returned.
            variable: VariableType.Class; -- 1..1 Required. The variable for which the result is returned.
         end record;      
      end GetVariableResultType;

      type Class is new callresult with record
         getVariableResult: GetVariableResultType.Class;
      end record;
      
      use GetVariableResultType;
      procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                      msgindex: in out Integer;
                      response: in out ocpp.GetVariables.Response.Class;
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
                      (response.getVariableResult.attributeType /= NonSparkTypes.AttributeEnumType.Invalid) and
                      (response.getVariableResult.attributeStatus /= NonSparkTypes.GetVariableStatusEnumType.Invalid)
                     )
                  );

      procedure To_Bounded_String(Self: in ocpp.getvariables.Response.Class;
                                  retval: out NonSparkTypes.packet.Bounded_String);

   end Response;
end ocpp.GetVariables;

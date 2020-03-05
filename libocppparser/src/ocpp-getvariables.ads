pragma SPARK_Mode (On);

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.action_t; use NonSparkTypes.AttributeEnumType;
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
      
end ocpp.GetVariables;

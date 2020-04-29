pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ocpp.ComponentType; use ocpp.ComponentType;
with ocpp.VariableType; use ocpp.VariableType;

package ocpp.SetVariableDataType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      attributeType : AttributeEnumType.T;
      attributeValue : NonSparkTypes.SetVariableDataType.strattributeValue_t.Bounded_String;
      component : ComponentType.T;
      variable : VariableType.T;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.SetVariableDataType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex, self),
                msgindex => (msg, msgIndex, self),
                self  => (msg, msgindex, self)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.SetVariableDataType;
pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ocpp.SetVariableStatusEnumType; use ocpp.SetVariableStatusEnumType;
with ocpp.ComponentType; use ocpp.ComponentType;
with ocpp.VariableType; use ocpp.VariableType;

package ocpp.SetVariableResultType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      attributeType : AttributeEnumType.T;
      attributeStatus : SetVariableStatusEnumType.T;
      component : ComponentType.T;
      variable : VariableType.T;
   end record;
   procedure Initialize(self: out ocpp.SetVariableResultType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.SetVariableResultType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgindex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.SetVariableResultType;
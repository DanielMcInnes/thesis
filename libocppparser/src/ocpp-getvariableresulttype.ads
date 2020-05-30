pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.GetVariableStatusEnumType; use ocpp.GetVariableStatusEnumType;
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ocpp.ComponentType; use ocpp.ComponentType;
with ocpp.VariableType; use ocpp.VariableType;

package ocpp.GetVariableResultType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      attributeStatus : GetVariableStatusEnumType.T;
      attributeType : AttributeEnumType.T;
      attributeValue : NonSparkTypes.GetVariableResultType.strattributeValue_t.Bounded_String;
      component : ComponentType.T;
      variable : VariableType.T;
   end record;
   procedure Initialize(self: out ocpp.GetVariableResultType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.GetVariableResultType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgindex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.GetVariableResultType;
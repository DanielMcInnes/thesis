pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ocpp.MutabilityEnumType; use ocpp.MutabilityEnumType;

package ocpp.VariableAttributeType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      zzztype : AttributeEnumType.T;
      value : NonSparkTypes.VariableAttributeType.strvalue_t.Bounded_String;
      mutability : MutabilityEnumType.T;
      persistent : boolean;
      zzzconstant : boolean;
   end record;
   procedure Initialize(self: out ocpp.VariableAttributeType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.VariableAttributeType.T;
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
end ocpp.VariableAttributeType;
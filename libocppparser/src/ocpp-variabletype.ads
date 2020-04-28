pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;

package ocpp.VariableType is
   type T is record
      zzzArrayElementInitialized : Boolean := True;
      name : NonSparkTypes.VariableType.strname_t.Bounded_String;
      instance : NonSparkTypes.VariableType.strinstance_t.Bounded_String;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.VariableType.T;
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
end ocpp.VariableType;
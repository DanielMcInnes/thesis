pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.EVSEType; use ocpp.EVSEType;

package ocpp.ComponentType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      evse : EVSEType.T;
      name : NonSparkTypes.ComponentType.strname_t.Bounded_String;
      instance : NonSparkTypes.ComponentType.strinstance_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.ComponentType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: out ocpp.ComponentType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgIndex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.ComponentType;
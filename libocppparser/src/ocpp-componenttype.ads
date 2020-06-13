pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ComponentTypestrings;
with ocpp.EVSEType; use ocpp.EVSEType;

package ocpp.ComponentType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      evse : EVSEType.T;
      name : ComponentTypeStrings.strname_t.Bounded_String;
      instance : ComponentTypeStrings.strinstance_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.ComponentType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.ComponentType.T;
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
end ocpp.ComponentType;
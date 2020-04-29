pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;

package ocpp.ModemType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      iccid : NonSparkTypes.ModemType.striccid_t.Bounded_String;
      imsi : NonSparkTypes.ModemType.strimsi_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.ModemType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: out ocpp.ModemType.T;
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
end ocpp.ModemType;
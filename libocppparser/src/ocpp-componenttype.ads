pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.EVSEType; use ocpp.EVSEType;

package ocpp.ComponentType is

   type T is record
      evse : EVSEType.T; -- TODO object;
      name : NonSparkTypes.ComponentType.strname.Bounded_String; -- TODO string;
      instance : NonSparkTypes.ComponentType.strinstance.Bounded_String;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.ComponentType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgIndex),
                self  => (msg, msgindex, self)
               );--,
-- TODO    post => (if valid = true then
--               (self.messagetypeid = 3) and
--               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)            

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.ComponentType;

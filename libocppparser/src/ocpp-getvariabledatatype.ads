pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with ocpp.ComponentType; use ocpp.ComponentType;
with ocpp.VariableType; use ocpp.VariableType;

package ocpp.GetVariableDataType is
   type T is record
      attributeType : AttributeEnumType.T; --string; -- TODO
      component : ComponentType.T; -- TODO
      variable : VariableType.T; --TODOobject;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.GetVariableDataType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex, self),
                msgindex => (msg, msgIndex, self),
                self  => (msg, msgindex, self)
               );--,
--    post => (if valid = true then
               --(self.messagetypeid = 3) and -- TODO
               --(NonSparkTypes.messageid_t.Length(self.messageid) > 0)            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.GetVariableDataType;

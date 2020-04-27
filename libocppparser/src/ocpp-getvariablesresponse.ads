pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.GetVariableResultType;

package ocpp.GetVariablesResponse is
   type T is new callresult with record
      getVariableResult : ocpp.GetVariableResultType.T; -- TODO
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.GetVariablesResponse.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex, self),
                msgindex => (msg, msgIndex, self),
                self  => (msg, msgindex, self)
               ),
    post => (if valid = true then
               (self.messagetypeid = 3) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.GetVariablesResponse;

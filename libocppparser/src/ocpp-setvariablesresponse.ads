pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.setVariableResultTypeArray;

package ocpp.SetVariablesResponse is
   type T is new callresult with record
      setVariableResult : setVariableResultTypeArray.T;
   end record;
   procedure Initialize(self: out ocpp.SetVariablesResponse.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: out ocpp.SetVariablesResponse.T;
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
end ocpp.SetVariablesResponse;
pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.integerType;
with ocpp.SetVariableResultType;

package ocpp.setVariableResultTypeArray is
type Index is range 1 .. 10;
type array_SetVariableResultType is array (Index) of ocpp.SetVariableResultType.T;
type T is record
   content : array_SetVariableResultType;
end record;
procedure Initialize(self: out ocpp.setVariableResultTypeArray.T)
  with
Global => null,
Annotate => (GNATprove, Terminating);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.setVariableResultTypeArray;

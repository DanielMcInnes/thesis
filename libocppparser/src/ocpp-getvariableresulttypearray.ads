pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.GetVariableResultType;

package ocpp.GetVariableResultTypeArray is
type Index is range 1 .. 100;
type array_GetVariableResultType is array (Index) of ocpp.GetVariableResultType.T;
type T is record
   content : array_GetVariableResultType;
end record;
procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.GetVariableResultTypeArray;

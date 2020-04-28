pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.SetVariableResultType;

package ocpp.SetVariableResultTypeArray is
type Index is range 1 .. 100;
type array_SetVariableResultType is array (Index) of ocpp.SetVariableResultType.T;
type T is record
   content : array_SetVariableResultType;
end record;
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean);

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.SetVariableResultTypeArray;

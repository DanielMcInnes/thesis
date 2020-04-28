pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.SetVariableDataType;

package ocpp.SetVariableDataTypeArray is
type Index is range 1 .. 100;
type array_SetVariableDataType is array (Index) of ocpp.SetVariableDataType.T;
type T is record
   content : array_SetVariableDataType;
end record;
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean);

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.SetVariableDataTypeArray;

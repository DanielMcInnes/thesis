pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.GetVariableDataType;

package ocpp.GetVariableDataTypeArray is
type Index is range 1 .. 100;
type array_GetVariableDataType is array (Index) of ocpp.GetVariableDataType.T;
type T is record
   content : array_GetVariableDataType;
end record;
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean);

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.GetVariableDataTypeArray;

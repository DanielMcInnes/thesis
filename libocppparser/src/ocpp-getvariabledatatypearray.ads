pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.GetVariableDataType;

package ocpp.GetVariableDataTypeArray is
type Index is range 1 .. 100;
type array_GetVariableDataType is array (Index) of ocpp.GetVariableDataType.T;
type T is record
   content : array_GetVariableDataType;
end record;
procedure Initialize(self: out ocpp.GetVariableDataTypeArray.T);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.GetVariableDataTypeArray;

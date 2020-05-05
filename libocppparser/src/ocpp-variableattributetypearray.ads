pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.VariableAttributeType;

package ocpp.VariableAttributeTypeArray is
type Index is range 1 .. 10;
type array_VariableAttributeType is array (Index) of ocpp.VariableAttributeType.T;
type T is record
   content : array_VariableAttributeType;
end record;
procedure Initialize(self: out ocpp.VariableAttributeTypeArray.T);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.VariableAttributeTypeArray;

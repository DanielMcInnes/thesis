pragma SPARK_mode (on); 

package body ocpp.SetVariableDataTypeArray is
procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean)
is
begin
   NonSparkTypes.put_line("SetVariableDataTypeArray.FromString");
end FromString;

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("SetVariableDataTypeArray.To_Bounded_String");
end To_Bounded_String;

end ocpp.SetVariableDataTypeArray;

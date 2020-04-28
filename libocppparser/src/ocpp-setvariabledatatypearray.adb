pragma SPARK_mode (on); 

package body ocpp.SetVariableDataTypeArray is
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean)
is
begin
   NonSparkTypes.put_line("SetVariableDataTypeArray.FromString");
end FromString;

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("SetVariableDataTypeArray.ToString");
end ToString;

end ocpp.SetVariableDataTypeArray;

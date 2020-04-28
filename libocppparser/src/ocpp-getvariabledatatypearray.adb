pragma SPARK_mode (on); 

package body ocpp.GetVariableDataTypeArray is
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean)
is
begin
   NonSparkTypes.put_line("GetVariableDataTypeArray.FromString");
end FromString;

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("GetVariableDataTypeArray.ToString");
end ToString;

end ocpp.GetVariableDataTypeArray;

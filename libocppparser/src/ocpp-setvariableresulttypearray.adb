pragma SPARK_mode (on); 

package body ocpp.SetVariableResultTypeArray is
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean)
is
begin
   NonSparkTypes.put_line("SetVariableResultTypeArray.FromString");
end FromString;

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("SetVariableResultTypeArray.ToString");
end ToString;

end ocpp.SetVariableResultTypeArray;

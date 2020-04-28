pragma SPARK_mode (on); 

package body ocpp.GetVariableResultTypeArray is
procedure FromString(msg: in string;
                     self: out T;
                    valid: out Boolean)
is
begin
   NonSparkTypes.put_line("GetVariableResultTypeArray.FromString");
end FromString;

procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("GetVariableResultTypeArray.ToString");
end ToString;

end ocpp.GetVariableResultTypeArray;

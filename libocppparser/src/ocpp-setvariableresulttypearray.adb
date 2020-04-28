pragma SPARK_mode (on); 

package body ocpp.SetVariableResultTypeArray is
procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean)
is
begin
   NonSparkTypes.put_line("SetVariableResultTypeArray.FromString");
end FromString;

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
begin
   NonSparkTypes.put_line("SetVariableResultTypeArray.To_Bounded_String");
end To_Bounded_String;

end ocpp.SetVariableResultTypeArray;

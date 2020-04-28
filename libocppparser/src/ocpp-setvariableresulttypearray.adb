with Ada.Strings; use Ada.Strings;

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
   dummybounded: NonSparkTypes.packet.Bounded_String;
begin
   for i in Index loop
      if (self.content(i).zzzArrayElementInitialized = True) then
         SetVariableResultType.To_Bounded_String(self.content(1), dummybounded);
         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);
      end if;
   end loop;
end To_Bounded_String;

end ocpp.SetVariableResultTypeArray;

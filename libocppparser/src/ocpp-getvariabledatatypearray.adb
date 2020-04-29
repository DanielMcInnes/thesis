pragma SPARK_mode (on); 

with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariableDataTypeArray is
procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean)
is
   tempBool : Boolean;
begin
   valid := false;
   for i in Index loop
      GetVariableDataType.parse(msg, msgIndex, self.content(i), tempBool);
      self.content(i).zzzArrayElementInitialized := tempBool;
      if tempBool = True then
         valid := True; -- need at least one valid item in the array for parsing to succeed
      end if;
   end loop;
end FromString;

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T)
is
   dummybounded: NonSparkTypes.packet.Bounded_String;
begin
   msg := NonSparkTypes.packet.To_Bounded_String("");
   NonSparkTypes.packet.Append(Source => msg, New_Item => "[",Drop => Right);
   for i in Index loop
      if (self.content(i).zzzArrayElementInitialized = True) then
         if i /= Index'First then
            NonSparkTypes.packet.Append(Source => msg, New_Item => ",",Drop => Right);
         end if;
         GetVariableDataType.To_Bounded_String(self.content(1), dummybounded);
         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);
      end if;
   end loop;
   NonSparkTypes.packet.Append(Source => msg, New_Item => "]",Drop => Right);
end To_Bounded_String;

end ocpp.GetVariableDataTypeArray;

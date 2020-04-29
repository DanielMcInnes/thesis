pragma SPARK_mode (on); 

with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariableResultTypeArray is
   procedure Initialize(self: out ocpp.GetVariableResultTypeArray.T)

   is
   begin
      for i in Index loop
         GetVariableResultType.Initialize(self.content(i));
         self.content(i).zzzArrayElementInitialized := False;
      end loop;
   end Initialize;
   procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                        msgindex: in out Integer;
                        self: out T;
                        valid: out Boolean)
   is
      tempBool : Boolean;
      last: Natural;
   begin
      valid := false;
      for i in Index loop
         GetVariableResultType.Initialize(self.content(i));
      end loop;
      for i in Index loop
         if i /= Index'First then 
            ocpp.move_index_past_token(msg, ',', msgindex, last);
            if (last = 0) then
               --put_line("39: no comma");
               self.content(i).zzzArrayElementInitialized := false;
               return; -- end of array
            end if;
         end if;
         GetVariableResultType.parse(msg, msgIndex, self.content(i), tempBool);
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
         exit when self.content(i).zzzArrayElementInitialized = False;
         if i /= Index'First then
            NonSparkTypes.packet.Append(Source => msg, New_Item => ",",Drop => Right);
         end if;
         GetVariableResultType.To_Bounded_String(self.content(i), dummybounded);
         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);
      end loop;
      NonSparkTypes.packet.Append(Source => msg, New_Item => "]",Drop => Right);
   end To_Bounded_String;

end ocpp.GetVariableResultTypeArray;

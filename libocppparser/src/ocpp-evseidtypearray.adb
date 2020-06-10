pragma SPARK_mode (on); 

with Ada.Strings; use Ada.Strings;

package body ocpp.evseIdTypeArray is
   procedure Initialize(self: out ocpp.evseIdTypeArray.T)

   is
   begin
      for i in Index loop
         integerType.Initialize(self.content(i));
         self.content(i).zzzArrayElementInitialized := False;
      end loop;
   end Initialize;

   procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                        msgindex: in out Integer;
                        self: out T;
                        valid: out Boolean)
   is
      last: Natural;
      tempIndex: Integer := msgIndex;
      lastIndex: Integer;
      tempBool: Boolean;
   begin
      valid := false;
      for i in Index loop
         integerType.Initialize(self.content(i));
      end loop;
      ocpp.moveIndexPastToken(msg, ']', tempIndex, lastIndex);
      NonSparkTypes.put("first: "); NonSparkTypes.put(msgindex'Image);
      NonSparkTypes.put(" last:"); NonSparkTypes.put_line(lastIndex'Image);
      NonSparkTypes.put(" tempIndex:"); NonSparkTypes.put_line(tempIndex'Image);
      tempIndex := msgindex;
      for i in Index loop
         if i /= Index'First
         then
           ocpp.moveIndexPastToken(msg, ',', tempIndex, last);
           if (tempIndex >= lastIndex) then
              self.content(i).zzzArrayElementInitialized := false;
              return; -- end of array
           end if;
           tempIndex := msgindex;           NonSparkTypes.put("moved past comma. tempIndex:"); NonSparkTypes.put_line(tempIndex'Image);
           if (last = 0) or (tempIndex > lastIndex) then
               --put_line("39: no comma");
               self.content(i).zzzArrayElementInitialized := false;
               return; -- end of array
            end if;
         end if;
         integerType.parse(msg, tempIndex, self.content(i), tempBool);
         self.content(i).zzzArrayElementInitialized := tempBool;
         NonSparkTypes.put("parsed AdditionalInfoType. tempIndex:"); NonSparkTypes.put(tempIndex'Image); NonSparkTypes.put_line(self.content(i).zzzArrayElementInitialized'Image);
         if self.content(i).zzzArrayElementInitialized = True then
            valid := True; -- need at least one valid item in the array for parsing to succeed
            msgIndex := tempIndex;
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
         integerType.To_Bounded_String(self.content(i), dummybounded);
         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);
      end loop;
      NonSparkTypes.packet.Append(Source => msg, New_Item => "]",Drop => Right);
   end To_Bounded_String;

end ocpp.evseIdTypeArray;

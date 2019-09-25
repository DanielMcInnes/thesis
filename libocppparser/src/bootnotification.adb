pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body BootNotification is

   function IsBootNotificationRequest(msg: Ada.Strings.Bounded.Generic_Bounded_Length (Max => 20)) return Integer is
      Tmp : constant Integer := 4;
      str : String := "";
   begin
      Put("IsBootNotificationRequest: ");
      str := Trim(msg, Left);
      Put_Line(str);
      
      return Tmp;
   end IsBootNotificationRequest;
   

end BootNotification;

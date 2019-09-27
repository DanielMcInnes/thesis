pragma SPARK_Mode (On);
pragma Inline (Max_Length);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps; use Ada.Strings.Maps;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;

package body BootNotification is

   function IsBootNotificationRequest(msg: SB) return Integer is
      Tmp : constant Integer := 4;
      str : String := "";
   begin
      Put("IsBootNotificationRequest: ");
      str := Trim(msg, Left);
      Put_Line(str);
      
      return Tmp;
   end IsBootNotificationRequest;
   

end BootNotification;

pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with bootnotification;

procedure Main is

   Dummy : Integer := 0;
   temp: Integer := 0;

--   [2,
--"19223201",
--"BootNotification",
--{
--"reason": "PowerUp",
--"chargingStation": {
--"model": "SingleSocketCharger",
--"vendorName": "VendorX"
--}
--}
--]


   function F return Integer is
      Tmp : constant Integer := Dummy;
   begin
      --Dummy := Dummy + 1;
      return Tmp;
   end F;

begin



   temp := F;

   Put(integer'Image(temp));   Put_Line("hello world");

   temp := BootNotification.IsBootNotificationRequest("lll");
   Put(integer'Image(temp));   Put_Line("hello world");


end Main;

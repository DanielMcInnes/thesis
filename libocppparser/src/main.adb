pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
procedure Main is

   package ocpp_packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);

   Dummy : Integer := 0;
   temp: Integer := 0;
   packet: ocpp_packet.Bounded_String := ocpp_packet.To_Bounded_String( ""
     & "[2," & ASCII.LF
     & '"'  &"19223201"  &'"' & "," & ASCII.LF
     & '"' & "BootNotification" & '"' & "," & ASCII.LF
     & "{" & ASCII.LF
     & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
     & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
     & '"' & "model"  & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
     & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
     & "}" & ASCII.LF
     & "}" & ASCII.LF
     & "]");

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

   Put_Line(ocpp_packet.To_String(packet));


end Main;

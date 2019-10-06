pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;
with ocpp;
with ocpp.BootNotifications;

procedure Main is
   Dummy : Integer := 0;
   b: ocpp.BootNotifications.BootNotification;

   --bootnotificationrequest : ocpp.BootNotifications.ptr := ocpp.BootNotifications.g_bootnotificationrequest'Access;

   packet: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String( ""
     & " [2," & ASCII.LF
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

--[2,
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

begin
   Put_Line(ocpp.packet.To_String(packet));
   ocpp.BootNotifications.parse(packet, b);
   put_line(ocpp.packet.To_String(b.reason));
end Main;

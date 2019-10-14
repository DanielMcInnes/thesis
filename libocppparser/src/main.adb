pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;
with ocpp;
with ocpp.BootNotification;
with ocpp.server;

procedure Main is
   --bootNotificationRequest: ocpp.BootNotification.Request;
   --valid: Boolean;
   server: ocpp.server.Class;

   packet: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String( ""
     & "[2," & ASCII.LF
     & '"'  &"19223201"  &'"' & "," & ASCII.LF
     & '"' & "BootNotification" & '"' & "," & ASCII.LF
     & "{" & ASCII.LF
     & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
     & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
     & "      " & '"' & "model"  & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
     & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
     & "   }" & ASCII.LF
     & "}" & ASCII.LF
     & "]");

   response: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String( "");

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
   Put_line("Receiving:");
   Put_Line(ocpp.packet.To_String(packet));
   --ocpp.BootNotification.parse(packet, bootNotificationRequest, valid);
   --put_line(ocpp.bootnotification_t.request.reason.To_String(bootNotificationRequest.reason));

   ocpp.server.handle(packet, response);
   Put_line("Sending:");
   Put_Line(ocpp.packet.To_String(response));

end Main;

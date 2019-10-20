pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;
with ocpp;
with ocpp.BootNotification;
with ocpp.server;
with NonSparkTypes;

procedure Main is
   server: ocpp.server.Class;

   packet: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String( ""
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

   response: NonSparkTypes.packet.Bounded_String;

begin
   Put_line("Receiving:");
   Put_Line(NonSparkTypes.packet.To_String(packet));
   ocpp.server.handle(packet, response);
   Put_line("Sending:");
   Put_Line(NonSparkTypes.packet.To_String(response));

end Main;

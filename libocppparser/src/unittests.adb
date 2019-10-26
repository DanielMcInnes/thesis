with ocpp;
with ocpp.BootNotification;
with ocpp.server;
with NonSparkTypes; use NonSparkTypes;

package body unittests is
   
   
   procedure testall(result: out Boolean)
   is
   begin
      B01(result);
      if (result = false) then
         return;
      end if;
            
   end testall;     
   

   procedure B01(result: out Boolean)
   is
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
      expectedresponse: NonSparkTypes.packet.Bounded_String :=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                & '"'  &"19223201"  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "   " & '"' & "interval" & '"' & ": 300," & ASCII.LF
                                                & "   " & '"' & "status" & '"' & ": " & '"' & "Accepted" & '"' & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
   begin
      result := false;
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(packet, response);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 50");
         return;
      end if;


      
      
      

      -- include the optional 'firmwareVersion' and 'serialNumber'
      packet := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &"19223201"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "01234567890123456789" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "model" & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
                                                        & "      " & '"' & "firmwareVersion"  & '"' & ":" & '"' & "01.23456789" & '"' & "," & ASCII.LF
                                                        & "   }" & ASCII.LF
                                                        & "}" & ASCII.LF
                                                        & "]");

      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(packet, response);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;


      
      
      
      
      -- include the optional 'modemInfo' and 'serialNumber'
      packet := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &"19223201"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "01234567890123456789" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "model"  & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
                                                        & "      " & '"' & "firmwareVersion"  & '"' & ":" & '"' & "01.23456789" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "modem"  & '"' & ":" & "{" & ASCII.LF
                                                        & "         " & '"' & "iccid" & '"' & ": " & '"' & "01234567890123456789" & '"' & ASCII.LF
                                                        & "         " & '"' & "imsi" & '"' & ": " & '"' & "01234567890123456789" & '"' & ASCII.LF
                                                        & "   }" & ASCII.LF
                                                        & "}" & ASCII.LF
                                                        & "]");

      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(packet, response);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;


      
      
      
      
      -- include the optional 'modemInfo' and the optional 'firmwareVersion' and 'serialNumber'
      packet := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &"19223201"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "01234567890123456789" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "model"  & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
                                                        & "      " & '"' & "modem"  & '"' & ":" & "{" & ASCII.LF
                                                        & "         " & '"' & "iccid" & '"' & ": " & '"' & "01234567890123456789" & '"' & ASCII.LF
                                                        & "         " & '"' & "imsi" & '"' & ": " & '"' & "01234567890123456789" & '"' & ASCII.LF
                                                        & "   }" & ASCII.LF
                                                        & "}" & ASCII.LF
                                                        & "]");

      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(packet, response);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;
      
      result := true;
      
   end B01;     
   

end unittests;

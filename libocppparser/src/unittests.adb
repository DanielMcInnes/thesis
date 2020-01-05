with ocpp;
with ocpp.BootNotification;
with ocpp.heartbeat;
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
            
      B03(result);
      if (result = false) then
         return;
      end if;
            
      B04(result);
      if (result = false) then
         return;
      end if;
            
   end testall;     
   

   procedure B01(result: out Boolean)
   is
      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("01234567890123456789");

      packet: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String( ""
                                                                                             & "[2," & ASCII.LF
                                                                                             & '"'  &"19223201"  &'"' & "," & ASCII.LF
                                                                                             & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                                                             & "{" & ASCII.LF
                                                                                             & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                                                             & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                                                             & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "01234567890123456789" & '"' & "," & ASCII.LF
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
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);
      result := false;
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
   

   procedure B03(result: out Boolean)
   is
      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("B030001");

      packet: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String( ""
                                                                                             & "[2," & ASCII.LF
                                                                                             & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                                                             & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                                                             & "{" & ASCII.LF
                                                                                             & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                                                             & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                                                             & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "B030001" & '"' & "," & ASCII.LF
                                                                                             & "      " & '"' & "model"  & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
                                                                                             & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
                                                                                             & "   }" & ASCII.LF
                                                                                             & "}" & ASCII.LF
                                                                                             & "]");

      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String :=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "   " & '"' & "interval" & '"' & ": 300," & ASCII.LF
                                                & "   " & '"' & "status" & '"' & ": " & '"' & "Rejected" & '"' & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
   begin
      result := false;
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server.enrolledChargers, packet, response);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 234");
         return;
      end if;

      -- include the optional 'firmwareVersion' and 'serialNumber'
      packet := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "B030001" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "model" & '"' & ":" & '"' & "SingleSocketCharger" & '"' & "," & ASCII.LF
                                                        & "      " & '"' & "vendorName" & '"' & ": " & '"' & "VendorX" & '"' & ASCII.LF
                                                        & "      " & '"' & "firmwareVersion"  & '"' & ":" & '"' & "01.23456789" & '"' & "," & ASCII.LF
                                                        & "   }" & ASCII.LF
                                                        & "}" & ASCII.LF
                                                        & "]");

      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server.enrolledChargers, packet, response);
      Put_line("257: expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;

      
      
      
      
      
      
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);
      
      expectedresponse :=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "   " & '"' & "interval" & '"' & ": 300," & ASCII.LF
                                                & "   " & '"' & "status" & '"' & ": " & '"' & "Accepted" & '"' & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
      
      
      
      
      -- include the optional 'modemInfo' and 'serialNumber'
      packet := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "B030001" & '"' & "," & ASCII.LF
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
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
                                                        & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                        & '"' & "BootNotification" & '"' & "," & ASCII.LF
                                                        & "{" & ASCII.LF
                                                        & "   " & '"' & "reason" & '"' & ": " & '"' & "PowerUp" & '"' & "," & ASCII.LF
                                                        & "   " & '"' & "chargingStation" & '"' & ": {" & ASCII.LF
                                                        & "      " & '"' & "serialNumber"  & '"' & ":" & '"' & "B030001" & '"' & "," & ASCII.LF
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
      ocpp.server.handle(server.enrolledChargers, packet, response);
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
      
   end B03;     
   
   procedure B04(result: out Boolean)
   is
      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("B030001");
      hbr: ocpp.heartbeat.Request;
      bnr: ocpp.BootNotification.Request := (
                                             messagetypeid => 2,
                                             messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                             action => action_t.To_Bounded_String("BootNotification"),
                                             reason => NonSparkTypes.BootReasonEnumType.To_Bounded_String("PowerUp"),
                                             chargingStation => (
                                                                 serialNumber => sn,
                                                                 model => NonSparkTypes.ChargingStationType.model.To_Bounded_String("SingleSocketCharger"),
                                                                 vendorName => NonSparkTypes.ChargingStationType.vendorName.To_Bounded_String("VendorX"),
                                                                 firmwareVersion => NonSparkTypes.ChargingStationType.firmwareVersion.To_Bounded_String("01.23456789"),
                                                                 modem => (
                                                                           iccid => ModemType.iccid_t.To_Bounded_String("01234567890123456789"),
                                                                           imsi => ModemType.imsi_t.To_Bounded_String("01234567890123456789")
                                                                          )
                                                                )                                                 
                                            );

      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String :=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                & '"'  &"19223202"  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "   " & '"' & "interval" & '"' & ": 300," & ASCII.LF
                                                & "   " & '"' & "status" & '"' & ": " & '"' & "Accepted" & '"' & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
   begin
      ocpp.heartbeat.DefaultInitialize(hbr);
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);     
      ocpp.BootNotification.To_Bounded_String(bnr, packet);      
      
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server.enrolledChargers, packet, response);
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

      ocpp.heartbeat.To_Bounded_String(hbr, packet);           
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server.enrolledChargers, packet, response);
      
      
      
      
      result := true;
   end B04;
   
end unittests;

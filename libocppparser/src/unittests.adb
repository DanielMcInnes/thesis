with ocpp;
with ocpp.BootNotification;
with ocpp.heartbeat;
with ocpp.setvariables;
with ocpp.server;
use ocpp.heartbeat;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t;
with System; use System;
with Ada.Strings; use Ada.Strings;
with ComponentType; 
with VariableType;

package body unittests is
   
   
   procedure testall(result: out Boolean)
   is
   begin
      B01(result);      if (result = false) then         return;      end if;
      B02(result);      if (result = false) then         return;      end if;
      B03(result);      if (result = false) then         return;      end if;
      B04(result);      if (result = false) then         return;      end if;
      
      --TODO:
      --B05
      --B06
      --B07 
      --B11
      --B12
      -- one of C01, C02, C04
      --E01 (one of S1 - S6)
      --E02
      --E03
      --E05
      --E06 (one of S1 - S6)
      --E07
      --E08
      -- one of E09-E10
      --E11
      --E12
      --E13
      --G01
      --G04
      --G05
      --G05
      --N07
      --J02
      --P01
      --P02
      
        
      
        
            
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
   
   procedure B02(result: out Boolean)
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
                                                & "   " & '"' & "status" & '"' & ": " & '"' & "Pending" & '"' & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
   begin
      ocpp.heartbeat.DefaultInitialize(hbr);
      server.isDeferringBootNotificationAccept := true;
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);
      ocpp.BootNotification.To_Bounded_String(bnr, packet);      
      
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server, packet, response);
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
      
      server.isDeferringBootNotificationAccept := false;
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

      ocpp.heartbeat.To_Bounded_String(hbr, packet);           
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.handle(server, packet, response);
      Put_line("expected response:");
      expectedresponse:=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                --                                                & '"'  & "19223202"  &'"' & "," & ASCII.LF
                                                & '"'  & NonSparkTypes.messageid_t.To_String(hbr.messageid)  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 438");
         return;
      end if;
      
      result := true;
   end B02;

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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
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
      ocpp.server.handle(server, packet, response);
      Put_line("expected response:");
      expectedresponse:=
        NonSparkTypes.packet.To_Bounded_String( ""
                                                & "[3," & ASCII.LF
                                                --                                                & '"'  & "19223202"  &'"' & "," & ASCII.LF
                                                & '"'  & NonSparkTypes.messageid_t.To_String(hbr.messageid)  &'"' & "," & ASCII.LF
                                                & "{" & ASCII.LF
                                                & "   " & '"' & "currentTime" & '"' & ": " & '"' & "2013-02-01T20:53:32.486Z" & '"' & "," & ASCII.LF
                                                & "}" & ASCII.LF
                                                & "]");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 438");
         return;
      end if;
      
      result := true;
   end B04;
   
   procedure B05(result: out Boolean)
   is
      use ocpp.setvariables.Request.DataType;

      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("01234567890123456789");
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

      --         type Class is tagged record
      --            attributeType: AttributeEnumType;
      --            attributeValue: attributeValue_t.Bounded_String;
      --            component: ComponentType.Class;
      --            variable: VariableType.Class;
      --         end record;
      
      setVariablesRequest : ocpp.setvariables.Request.Class := (
                                                                messagetypeid => 2,
                                                                messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                action => action_t.To_Bounded_String("SetVariables"),
                                                                setVariableData => (
                                                                                        attributeType => ocpp.Actual,
                                                                                        attributeValue => ocpp.setvariables.Request.DataType.attributeValue_t.To_Bounded_String("Hello World!"),
                                                                                        component => (
                                                                                                      name => ComponentType.name.To_Bounded_String(""),
                                                                                                      instance => ComponentType.instance.To_Bounded_String(""),
                                                                                                      evse => (
                                                                                                               id => 0,
                                                                                                               connectorId => 0
                                                                                                              )
                                                                                                     ),
                                                                                        variable => (
                                                                                                     name => VariableType.name.To_Bounded_String(""),
                                                                                                     instance => VariableType.instance.To_Bounded_String("")
                                                                                                    )
                                                                                       )
                                                               );
   begin
      result := false;
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);     
      ocpp.BootNotification.To_Bounded_String(bnr, packet);      
      
      
   end B05;
     
end unittests;

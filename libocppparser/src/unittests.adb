with ocpp; use ocpp;
with ocpp.heartbeat; use ocpp.heartbeat;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t;
with System; use System;
with Ada.Strings; use Ada.Strings;

with ocpp.BootNotification;
with ocpp.SetVariables;
with ocpp.GetVariables;
with ocpp.server;
with ocpp.VariableType;
with ComponentType; 

with ocpp.ResetEnumType;
with ocpp.ReportBaseEnumType;
with ocpp.GenericDeviceModelStatusEnumType;
with ocpp.GetVariableStatusEnumType;
with ocpp.AttributeEnumType;
with ocpp.TransactionEventEnumType;
with ocpp.TriggerReasonEnumType;
with ocpp.CertificateStatusEnumType;
with ocpp.ConnectorStatusEnumType;
with ocpp.TriggerReasonEnumType;
with ocpp.SignatureMethodEnumType;
with ocpp.ChargingStateEnumType;
with ocpp.encodingmethodenumtype;

package body unittests is
   
   procedure fail is
   begin
      Put_line("FAIL");
      
   end fail;
   
   procedure testall(result: out Boolean)
   is
   begin
      B01(result);      if (result = false) then         fail; return;      end if;
      B02(result);      if (result = false) then         fail; return;      end if;
      B03(result);      if (result = false) then         fail; return;      end if;
      B04(result);      if (result = false) then         fail; return;      end if;
      B05(result);      if (result = false) then         fail; return;      end if;
      B06(result);      if (result = false) then         fail; return;      end if;
      B07(result);      if (result = false) then         fail; return;      end if;
      
      --TODO:
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
      valid: Boolean;

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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      valid: Boolean;
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      valid: Boolean;

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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      valid: Boolean;
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      ocpp.server.receivePacket(server, packet, response, valid);
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
      use ocpp.SetVariables.Response;
      use ocpp.SetVariables.Request.DataType;

      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("01234567890123456789");
      valid: Boolean;
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

      setVariablesRequest : ocpp.SetVariables.Request.Class := (
                                                                messagetypeid => 2,
                                                                messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                action => action_t.To_Bounded_String("SetVariables"),
                                                                setVariableData => (
                                                                                    attributeType => AttributeEnumType.Actual,
                                                                                    attributeValue => NonSparkTypes.attributeValue_t.string_t.To_Bounded_String("p@ssw0rd"),
                                                                                    component => (
                                                                                                  name => ComponentType.name.To_Bounded_String("evse"),
                                                                                                  instance => ComponentType.instance.To_Bounded_String("0"),
                                                                                                  evse => (
                                                                                                           id => 0,
                                                                                                           connectorId => 0
                                                                                                          )
                                                                                                 ),
                                                                                    variable => (
                                                                                                 name => NonSparkTypes.VariableType_t.name.To_Bounded_String("loginPassword"),
                                                                                                 instance => NonSparkTypes.VariableType_t.instance.To_Bounded_String("0")
                                                                                                )
                                                                                   )
                                                               );
      
      setVariablesResponse : ocpp.SetVariables.Response.Class := (
                                                                  messagetypeid => 3,
                                                                  messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                  setVariableResult => (
                                                                                        attributeType => AttributeEnumType.Actual,
                                                                                        attributeStatus => ocpp.SetVariables.Response.SetVariableResultType.Accepted,
                                                                                        component => (
                                                                                                      name => ComponentType.name.To_Bounded_String("name001"),
                                                                                                      instance => ComponentType.instance.To_Bounded_String("instance001"),
                                                                                                      evse => (
                                                                                                               id => 0,
                                                                                                               connectorId => 0
                                                                                                              )
                                                                                                     ),
                                                                                        variable => (
                                                                                                     name => NonSparkTypes.VariableType_t.name.To_Bounded_String("loginPassword"),
                                                                                                     instance => NonSparkTypes.VariableType_t.instance.To_Bounded_String("0")
                                                                                                    )
                                                                                       )
                                                                  
                                                                 );
   begin
      result := false;
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);     

      ocpp.BootNotification.To_Bounded_String(bnr, packet);      
      ocpp.server.receivePacket(server, packet, response, valid);
      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 663");
         return;
      end if;
      
      ocpp.setvariables.Request.To_Bounded_String(setVariablesRequest, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      
      ocpp.SetVariables.Response.To_Bounded_String(setVariablesResponse, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.receivePacket(server, packet, response, result);

      if (server.setVariablesResponse = setVariablesResponse)
      then
         result := true;
      else
         result := false;
      end if;
      
      ocpp.SetVariables.Response.To_Bounded_String(server.setVariablesResponse, response);
      put_line(NonSparkTypes.packet.To_String(response));
      
   end B05;

   procedure B06(result: out Boolean)
   is
      use ocpp.GetVariables.Response;
      server: ocpp.server.Class;
      sn : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("01234567890123456789");
      valid: Boolean;
      dummystring: NonSparkTypes.packet.Bounded_String;
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

      getVariablesRequest : ocpp.GetVariables.Request.Class := (
                                                                messagetypeid => 2,
                                                                messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                action => action_t.To_Bounded_String("GetVariables"),
                                                                getVariableData => (
                                                                                    attributeType => AttributeEnumType.Actual,
                                                                                    component => (
                                                                                                  name => ComponentType.name.To_Bounded_String("evse"),
                                                                                                  instance => ComponentType.instance.To_Bounded_String("0"),
                                                                                                  evse => (
                                                                                                           id => 0,
                                                                                                           connectorId => 0
                                                                                                          )
                                                                                                 ),
                                                                                    variable => (
                                                                                                 name => NonSparkTypes.VariableType_t.name.To_Bounded_String("loginPassword"),
                                                                                                 instance => NonSparkTypes.VariableType_t.instance.To_Bounded_String("0")
                                                                                                )
                                                                                   )
                                                               );
      getVariablesResponse : ocpp.GetVariables.Response.Class := (
                                                                  messagetypeid => 3,
                                                                  messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                  getVariableResult => (
                                                                                        attributeStatus => ocpp.GetVariableStatusEnumType.Accepted,
                                                                                        attributeType => AttributeEnumType.Actual,
                                                                                        attributeValue => NonSparkTypes.attributeValue_t.string_t.To_Bounded_String("p@ssw0rd"),
                                                                                    component => (
                                                                                                  name => ComponentType.name.To_Bounded_String("evse"),
                                                                                                  instance => ComponentType.instance.To_Bounded_String("0"),
                                                                                                  evse => (
                                                                                                           id => 0,
                                                                                                           connectorId => 0
                                                                                                          )
                                                                                                 ),
                                                                                    variable => (
                                                                                                 name => NonSparkTypes.VariableType_t.name.To_Bounded_String("loginPassword"),
                                                                                                 instance => NonSparkTypes.VariableType_t.instance.To_Bounded_String("0")
                                                                                                )
                                                                                       )
                                                                  
                                                                 );
   begin
      result := false;
      ocpp.server.enrolChargingStation(server.enrolledChargers, sn, result);     

      ocpp.BootNotification.To_Bounded_String(bnr, packet);      
      ocpp.server.receivePacket(server, packet, response, valid);
      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 765");
         return;
      end if;
      
      ocpp.GetVariables.Request.To_Bounded_String(getVariablesRequest, packet);
      NonSparkTypes.put_line("sending:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      
      ocpp.GetVariables.Response.To_Bounded_String(getVariablesResponse, packet);
      NonSparkTypes.put_line("receiving:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.receivePacket(server, packet, response, result);
      if (result = false) then return; end if;
      
      if(server.getVariablesResponse /= getVariablesResponse) 
      then 
         NonSparkTypes.put_line("ERROR 804");
         ocpp.GetVariables.Response.To_Bounded_String(server.getVariablesResponse, dummystring);
         NonSparkTypes.put_line(NonSparkTypes.packet.To_String(dummystring));
         
         
         result := false; 
         return; 
      end if;
      
      
      
      
      result := true;
   end B06;
   
   procedure B07(result: out Boolean)
   is
   begin
      
      NonSparkTypes.put_line("B07");
      result := true;
   end B07;
   
      
   
     
end unittests;

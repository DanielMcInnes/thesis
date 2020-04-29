with ocpp; use ocpp;
with ocpp.heartbeat; use ocpp.heartbeat;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t; use NonSparkTypes.packet;
with System; use System;
with Ada.Strings; use Ada.Strings;

with ocpp.BootNotification;
with ocpp.ComponentType;
with ocpp.CustomDataType;
with ocpp.GetVariableDataTypeArray;
with ocpp.GetVariablesRequest; use ocpp.GetVariablesRequest;
with ocpp.GetVariablesResponse;
with ocpp.GetVariableResultType;
with ocpp.server;
with ocpp.SetVariablesRequest;
with ocpp.SetVariablesResponse;
with ocpp.VariableType;

with ocpp.A15118evcertificatestatusenumtype;
with ocpp.AttributeEnumType;
with ocpp.apnauthenticationenumtype;
with ocpp.AttributeEnumType;
with ocpp.authorizationstatusenumtype;
with ocpp.authorizecertificatestatusenumtype;
with ocpp.bootreasonenumtype;
with ocpp.CancelReservationStatusEnumType;
with ocpp.CertificateActionEnumType;
with ocpp.CertificateSignedStatusEnumType;
with ocpp.CertificateSigningUseEnumType;
with ocpp.CertificateStatusEnumType;
with ocpp.ChangeAvailabilityStatusEnumType;
with ocpp.charginglimitsourceenumtype;
with ocpp.chargingprofilekindenumtype;
with ocpp.chargingprofilepurposeenumtype;
with ocpp.ChargingProfileStatusEnumType;
with ocpp.chargingrateunitenumtype;
with ocpp.ChargingStateEnumType;
with ocpp.clearmonitoringstatusenumtype;
with ocpp.ClearCacheStatusEnumType;
with ocpp.ClearChargingProfileStatusEnumType;
with ocpp.ClearMessageStatusEnumType;
with ocpp.ClearMonitoringStatusEnumType;
with ocpp.componentcriterionenumtype;
with ocpp.connectorenumtype;
with ocpp.ConnectorStatusEnumType;
with ocpp.costkindenumtype;
with ocpp.CustomerInformationStatusEnumType;
with ocpp.dataenumtype;
with ocpp.EncodingMethodEnumType;
with ocpp.energytransfermodeenumtype;
with ocpp.eventtriggerenumtype;
with ocpp.ConnectorStatusEnumType;
with ocpp.DataTransferStatusEnumType;
with ocpp.DeleteCertificateStatusEnumType;
with ocpp.DeleteCertificateStatusEnumType;
with ocpp.DisplayMessageStatusEnumType;
with ocpp.EncodingMethodEnumType;
with ocpp.EnergyTransferModeEnumType;
with ocpp.EventNotificationEnumType;
with ocpp.EventTriggerEnumType;
with ocpp.FirmwareStatusEnumType;
with ocpp.GenericDeviceModelStatusEnumType;
with ocpp.GenericStatusEnumType;
with ocpp.GetCertificateIdUseEnumType;
with ocpp.GetCertificateStatusEnumType;
with ocpp.GetChargingProfileStatusEnumType;
with ocpp.getcompositeschedulestatusenumtype;
with ocpp.GetDisplayMessagesStatusEnumType;
with ocpp.getinstalledcertificatestatusenumtype;
with ocpp.GetVariableStatusEnumType;
with ocpp.hashalgorithmenumtype;
with ocpp.idtokenenumtype;
with ocpp.InstallCertificateStatusEnumType;
with ocpp.InstallCertificateUseEnumType;
with ocpp.Isoa15118EVCertificateStatusEnumType;
with ocpp.locationenumtype;
with ocpp.logenumtype;
with ocpp.LogStatusEnumType;
with ocpp.measurandenumtype;
with ocpp.messageformatenumtype;
with ocpp.messagepriorityenumtype;
with ocpp.messagestateenumtype;
with ocpp.messagetriggerenumtype;
with ocpp.monitorenumtype;
with ocpp.MonitoringBaseEnumType;
with ocpp.monitoringcriterionenumtype;
with ocpp.mutabilityenumtype;
with ocpp.NotifyEVChargingNeedsStatusEnumType;
with ocpp.ocppinterfaceenumtype;
with ocpp.ocpptransportenumtype;
with ocpp.ocppversionenumtype;
with ocpp.OperationalStatusEnumType;
with ocpp.phaseenumtype;
with ocpp.PublishFirmwareStatusEnumType;
with ocpp.readingcontextenumtype;
with ocpp.reasonenumtype;
with ocpp.recurrencykindenumtype;
with ocpp.RegistrationStatusEnumType;
with ocpp.ReportBaseEnumType;
with ocpp.RequestStartStopStatusEnumType;
with ocpp.ReservationUpdateStatusEnumType;
with ocpp.ReserveNowStatusEnumType;
with ocpp.ResetEnumType;
with ocpp.ResetStatusEnumType;
with ocpp.setmonitoringstatusenumtype;
with ocpp.SetNetworkProfileStatusEnumType;
with ocpp.setvariablestatusenumtype;
with ocpp.SignatureMethodEnumType;
with ocpp.TransactionEventEnumType;
with ocpp.TriggerMessageStatusEnumType;
with ocpp.TriggerReasonEnumType;
with ocpp.UnlockStatusEnumType;
with ocpp.UnpublishFirmwareStatusEnumType;
with ocpp.updateenumtype;
with ocpp.UpdateFirmwareStatusEnumType;
with ocpp.UpdateStatusEnumType;
with ocpp.UploadLogStatusEnumType;
with ocpp.vpnenumtype;

with ocpp.GetBaseReportRequest;
with ocpp.GetBaseReportResponse;

package body unittests is
   
   procedure fail is
   begin
      Put_line("FAIL");
      
   end fail;
   
   procedure testall(result: out Boolean)
   is
   begin
      --      B01(result);      if (result = false) then         fail; return;      end if;
      --      B02(result);      if (result = false) then         fail; return;      end if;
      --      B03(result);      if (result = false) then         fail; return;      end if;
      --      B04(result);      if (result = false) then         fail; return;      end if;
      --      B05(result);      if (result = false) then         fail; return;      end if;
      B06(result);      if (result = false) then         fail; return;      end if;
      --      B07(result);      if (result = false) then         fail; return;      end if; -- GetBaseReportRequest
      
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
      use ocpp.SetVariablesResponse;
      --use ocpp.SetVariablesRequest.DataType;

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

      setVariablesRequest : ocpp.SetVariablesRequest.T := (
                                                           messagetypeid => 2,
                                                           messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                           action => action_t.To_Bounded_String("SetVariables"),
                                                           setVariableData => ( content => ( others => (
                                                                                                        zzzArrayElementInitialized => False,
                                                                                                        attributeType => AttributeEnumType.Actual,
                                                                                                        attributeValue => NonSparkTypes.SetVariableDataType.strattributeValue_t.To_Bounded_String("p@ssw0rd"),
                                                                                                        component => (
                                                                                                                      zzzArrayElementInitialized => False,
                                                                                                                      name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String("evse"),
                                                                                                                      instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("0"),
                                                                                                                      evse => (
                                                                                                                               zzzArrayElementInitialized => False,
                                                                                                                               id => 0,
                                                                                                                               connectorId => 0
                                                                                                                              )
                                                                                                                     ),
                                                                                                        variable => (
                                                                                                                     zzzArrayElementInitialized => False,
                                                                                                                     name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                     instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("0")
                                                                                                                    )
                                                                                                       ))
                                                                               ));
      
      setVariablesResponse : ocpp.SetVariablesResponse.T := (
                                                             messagetypeid => 3,
                                                             messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                             setVariableResult => ( content => ( others => (
                                                                                                            zzzArrayElementInitialized => False,
                                                                                                            attributeType => AttributeEnumType.Actual,
                                                                                                            attributeStatus => ocpp.SetVariableStatusEnumType.Accepted,
                                                                                                            component => (
                                                                                                                          zzzArrayElementInitialized => False,
                                                                                                                          name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String("name001"),
                                                                                                                          instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("instance001"),
                                                                                                                          evse => (
                                                                                                                                   zzzArrayElementInitialized => False,
                                                                                                                                   id => 0,
                                                                                                                                   connectorId => 0
                                                                                                                                  )
                                                                                                                         ),
                                                                                                            variable => (
                                                                                                                         zzzArrayElementInitialized => False,
                                                                                                                         name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                         instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("0")
                                                                                                                        )
                                                                                                           )
                                                                  
                                                                                                )));
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
      
      ocpp.setvariablesRequest.To_Bounded_String(setVariablesRequest, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      
      ocpp.SetVariablesResponse.To_Bounded_String(setVariablesResponse, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.receivePacket(server, packet, response, result);

      if (server.setVariablesResponse = setVariablesResponse)
      then
         result := true;
      else
         result := false;
      end if;
      
      ocpp.SetVariablesResponse.To_Bounded_String(server.setVariablesResponse, response);
      put_line(NonSparkTypes.packet.To_String(response));
      
   end B05;

   procedure B06(result: out Boolean)
   is
      use ocpp.GetVariablesResponse;
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
      strServerPacket: NonSparkTypes.packet.Bounded_String;
      strTestPacket: NonSparkTypes.packet.Bounded_String;
      
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

      getVariablesRequest : ocpp.GetVariablesRequest.T := (
                                                           messagetypeid => 2,
                                                           messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                           action => action_t.To_Bounded_String("GetVariables"),
                                                           getVariableData => ( 
                                                                                content => (
                                                                                            1 => (
                                                                                                        zzzArrayElementInitialized => True,
                                                                                                        attributeType => AttributeEnumType.Actual,
                                                                                                        component => (
                                                                                                                      zzzArrayElementInitialized => False,
                                                                                                                      name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String ("evse", Drop => Right),
                                                                                                                      instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("10"),
                                                                                                                      evse => (
                                                                                                                               zzzArrayElementInitialized => False,
                                                                                                                               id => 11,
                                                                                                                               connectorId => 12
                                                                                                                              )
                                                                                                                     ),
                                                                                                        variable => (
                                                                                                                     zzzArrayElementInitialized => False,
                                                                                                                     name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                     instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("13")
                                                                                                                    )
                                                                                                      ),
                                                                                            2 => (
                                                                                                        zzzArrayElementInitialized => True,
                                                                                                        attributeType => AttributeEnumType.MaxSet,
                                                                                                        component => (
                                                                                                                      zzzArrayElementInitialized => False,
                                                                                                                      name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String ("evse", Drop => Right),
                                                                                                                      instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("20"),
                                                                                                                      evse => (
                                                                                                                               zzzArrayElementInitialized => False,
                                                                                                                               id => 21,
                                                                                                                               connectorId => 22
                                                                                                                              )
                                                                                                                     ),
                                                                                                        variable => (
                                                                                                                     zzzArrayElementInitialized => False,
                                                                                                                     name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                     instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("0")
                                                                                                                    )
                                                                                                      ),
                                                                                            others => (
                                                                                                        zzzArrayElementInitialized => False,
                                                                                                        attributeType => AttributeEnumType.Actual,
                                                                                                        component => (
                                                                                                                      zzzArrayElementInitialized => False,
                                                                                                                      name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String ("", Drop => Right),
                                                                                                                      instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String(""),
                                                                                                                      evse => (
                                                                                                                               zzzArrayElementInitialized => False,
                                                                                                                               id => 0,
                                                                                                                               connectorId => 0
                                                                                                                              )
                                                                                                                     ),
                                                                                                        variable => (
                                                                                                                     zzzArrayElementInitialized => False,
                                                                                                                     name => NonSparkTypes.VariableType.strname_t.To_Bounded_String(""),
                                                                                                                     instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("")
                                                                                                                    )
                                                                                                      )
                                                                                           )
                                                                               )
                                                          );
      getVariablesResponse : ocpp.GetVariablesResponse.T := (
                                                             messagetypeid => 3,
                                                             messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                             getVariableResult => (
                                                                                    content => (
                                                                                                 1 => (
                                                                                                            zzzArrayElementInitialized => True,
                                                                                                            attributeStatus => ocpp.GetVariableStatusEnumType.Accepted,
                                                                                                            attributeType => AttributeEnumType.Actual,
                                                                                                            attributeValue => NonSparkTypes.GetVariableResultType.strattributeValue_t.To_Bounded_String("p@ssw0rd"),
                                                                                                            component => (
                                                                                                                          zzzArrayElementInitialized => True,
                                                                                                                          name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String("evse"),
                                                                                                                          instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("0"),
                                                                                                                          evse => (
                                                                                                                                   zzzArrayElementInitialized => True,
                                                                                                                                   id => 0,
                                                                                                                                   connectorId => 0
                                                                                                                                  )
                                                                                                                         ),
                                                                                                            variable => (
                                                                                                                         zzzArrayElementInitialized => True,
                                                                                                                         name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                         instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("0")
                                                                                                                        )
                                                                                                           ),
                                                                                                 others => (
                                                                                                            zzzArrayElementInitialized => False,
                                                                                                            attributeStatus => ocpp.GetVariableStatusEnumType.Accepted,
                                                                                                            attributeType => AttributeEnumType.Actual,
                                                                                                            attributeValue => NonSparkTypes.GetVariableResultType.strattributeValue_t.To_Bounded_String("p@ssw0rd"),
                                                                                                            component => (
                                                                                                                          zzzArrayElementInitialized => False,
                                                                                                                          name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String("evse"),
                                                                                                                          instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("0"),
                                                                                                                          evse => (
                                                                                                                                   zzzArrayElementInitialized => False,
                                                                                                                                   id => 0,
                                                                                                                                   connectorId => 0
                                                                                                                                  )
                                                                                                                         ),
                                                                                                            variable => (
                                                                                                                         zzzArrayElementInitialized => False,
                                                                                                                         name => NonSparkTypes.VariableType.strname_t.To_Bounded_String("loginPassword"),
                                                                                                                         instance => NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("0")
                                                                                                                        )
                                                                                                           )
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
      
      ocpp.GetVariablesRequest.To_Bounded_String(getVariablesRequest, packet);
      NonSparkTypes.put_line("sending:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.sendRequest(server, getVariablesRequest);
      
      ocpp.GetVariablesResponse.To_Bounded_String(getVariablesResponse, packet);
      NonSparkTypes.put_line("receiving:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.receivePacket(server, packet, response, result);
      if (result = false) then return; end if;
      
      ocpp.GetVariablesResponse.To_Bounded_String(server.getVariablesResponse, strServerPacket);
      ocpp.GetVariablesResponse.To_Bounded_String(getVariablesResponse, strTestPacket);
      if(strTestPacket /= strServerPacket) 
      then 
         NonSparkTypes.put_line("ERROR 804");
         ocpp.GetVariablesResponse.To_Bounded_String(server.getVariablesResponse, dummystring);
         NonSparkTypes.put_line(NonSparkTypes.packet.To_String(dummystring));
         
         
         result := false; 
         return; 
      end if;
      
      
      
      
      result := true;
   end B06;
   
   procedure B07(result: out Boolean)
   is
      dummystring: NonSparkTypes.packet.Bounded_String;
      getBaseReportRequest: ocpp.GetBaseReportRequest.T := (
                                                            messagetypeid => 2,
                                                            messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                            action => ocpp.GetBaseReportRequest.action,
                                                            requestId => 1,
                                                            reportBase => ReportBaseEnumType.ConfigurationInventory
                                                           );
      getBaseReportResponse: ocpp.GetBaseReportResponse.T := (
                                                              messagetypeid => 3,
                                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                              status => GenericDeviceModelStatusEnumType.Accepted
                                                             );
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
      expectedresponse: NonSparkTypes.packet.Bounded_String;
      
   begin      
      NonSparkTypes.put_line("B07");
      result := false;
      getBaseReportRequest.To_Bounded_String(expectedresponse);
      getBaseReportRequest.To_Bounded_String(dummystring);
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(dummystring));
      
      ocpp.server.receivePacket(server, dummystring, response, valid); 
      if (dummystring = expectedresponse) 
      then
         NonSparkTypes.put_line("B07 1 passed.");
      end if;
      
      GetBaseReportResponse.To_Bounded_String(response);
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(response));
      ocpp.server.receivePacket(server, response, dummystring, valid);
      
      result := valid;
   end B07;
   
      
   
     
end unittests;

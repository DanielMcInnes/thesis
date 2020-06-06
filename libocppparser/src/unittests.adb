with ocpp; use ocpp;
with ocpp.HeartbeatRequest;
with ocpp.HeartbeatResponse;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t; use NonSparkTypes.packet;
with System; use System;
with Ada.Strings; use Ada.Strings;

with ocpp.BootNotificationRequest;
with ocpp.BootNotificationResponse;
with ocpp.BootReasonEnumType;
with ocpp.ComponentType;
with ocpp.CustomDataType;
with ocpp.GetVariableDataTypeArray;
with ocpp.GetVariablesRequest; use ocpp.GetVariablesRequest;
with ocpp.GetVariablesResponse;
with ocpp.GetVariableResultType;
with ocpp.server;
with ocpp.SetVariablesRequest;
with ocpp.SetVariablesResponse;
with ocpp.StatusNotificationRequest;
with ocpp.StatusNotificationResponse;
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
      B01(result);      if (result = false) then         fail; return;      end if;
      B02(result);      if (result = false) then         fail; return;      end if;
      B03(result);      if (result = false) then         fail; return;      end if;
      B04(result);      if (result = false) then         fail; return;      end if;
      B05(result);      if (result = false) then         fail; return;      end if;
      B06(result);      if (result = false) then         fail; return;      end if;
      B07(result);      if (result = false) then         fail; return;      end if; -- GetBaseReportRequest
      
      --TODO:
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
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String ("00000000000000000001");
      sn2 : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("00000000000000000002");
      sn3 : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      valid: Boolean;

      packet: NonSparkTypes.packet.Bounded_String;
      bootNotificationRequest: ocpp.BootNotificationRequest.T := (
                                                                  messagetypeid => 2,
                                                                  messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                  action => action_t.To_Bounded_String("BootNotification"),
                                                                  reason => BootReasonEnumType.PowerUp,
                                                                  chargingStation => (
                                                                                      zzzArrayElementInitialized => False,
                                                                                      serialNumber => sn,
                                                                                      model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                                      vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                                      firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                                      modem => (
                                                                                                zzzArrayElementInitialized => False,
                                                                                                iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                                                imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                                               )
                                                                                     )                                                 
                                                                 );
      BootNotificationResponse: ocpp.BootNotificationResponse.T := (
                                                                    messagetypeid => 3,
                                                                    messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                    currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                                    interval => 300,
                                                                    status => RegistrationStatusEnumType.Accepted
                                                                   );


      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;

      statusnotificationrequest: ocpp.StatusNotificationRequest.T := 
        (
         messageTypeId => 2,
         messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
         action => ocpp.StatusNotificationRequest.action,
         timestamp => NonSparkTypes.StatusNotificationRequest.strtimestamp_t.To_Bounded_String("1234"),
         connectorStatus => ocpp.ConnectorStatusEnumType.Available,
         evseId => 1,
         connectorId => 1         
        );
      statusnotificationresponse: ocpp.StatusNotificationResponse.T := 
        (
         unused => -1,
         messageTypeId => 3,
         messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202")
        );
   begin
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);
      if (result = False) then return; end if;
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn2, result);
      if (result = False) then return; end if;
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn3, result);
      if (result = False) then return; end if;
      result := false;
      

      bootNotificationRequest.To_Bounded_String(packet);
      

      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);
      
      bootNotificationResponse.To_Bounded_String(expectedresponse);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (response = expectedresponse) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;
      
      statusnotificationrequest.To_Bounded_String(packet);
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, result);
      
      statusnotificationresponse.To_Bounded_String(expectedresponse);
      if (response /= expectedresponse) then result := false; end if;
        
      
   end B01;     
   
   procedure B02(result: out Boolean)
   is
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("B030001");
      valid: Boolean;
      heartbeatRequest: ocpp.heartbeatRequest.T := (
                                                    messagetypeid => 2,
                                                    messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                    action => action_t.To_Bounded_String("Heartbeat"),
                                                    unused => -1
                                                   );
      heartbeatResponse: ocpp.HeartbeatResponse.T := (
                                                      messagetypeid => 3,
                                                      messageid => heartbeatRequest.messageid,
                                                      currentTime => NonSparkTypes.HeartbeatResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z")                                                      
                                                     );
      
      bnr: ocpp.BootNotificationRequest.T := (
                                              messagetypeid => 2,
                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                              action => action_t.To_Bounded_String("BootNotification"),
                                              reason => BootReasonEnumType.PowerUp,
                                              chargingStation => (
                                                                  zzzArrayElementInitialized => False,
                                                                  serialNumber => sn,
                                                                  model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                  vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                  firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                  modem => (
                                                                            zzzArrayElementInitialized => False,
                                                                            iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                            imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                           )
                                                                 )                                                 
                                             );
      
      bootNotificationResponse: ocpp.BootNotificationResponse.T := (
                                                                    messagetypeid => 3,
                                                                    messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                    currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                                    interval => 300,
                                                                    status => RegistrationStatusEnumType.Pending
                                                                   );

      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;
   begin
         
         
      server.isDeferringBootNotificationAccept := true;
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);
      ocpp.BootNotificationRequest.To_Bounded_String(bnr, packet);      
      
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);

      bootNotificationResponse.To_Bounded_String(expectedresponse);
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

      heartbeatRequest.To_Bounded_String(packet);           
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));

      
      server.ReceivePacket(packet, response, valid);
      if (valid = false) then
         NonSparkTypes.put_line("ERROR 357");
         return;
      end if;
        
      
      
      
      Put_line("expected response:");

      heartbeatResponse.To_Bounded_String(expectedresponse);
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 371");
         return;
      end if;
      
      result := true;
   end B02;

   procedure B03(result: out Boolean)
   is
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("B030001");
      valid: Boolean;
      bootNotificationRequest: ocpp.BootNotificationRequest.T := (
                                                                  messagetypeid => 2,
                                                                  messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                                  action => action_t.To_Bounded_String("BootNotification"),
                                                                  reason => BootReasonEnumType.PowerUp,
                                                                  chargingStation => (
                                                                                      zzzArrayElementInitialized => False,
                                                                                      serialNumber => sn,
                                                                                      model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                                      vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                                      firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                                      modem => (
                                                                                                zzzArrayElementInitialized => False,
                                                                                                iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                                                imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                                               )
                                                                                     )                                                 
                                                                 );
      expectedresponse: ocpp.BootNotificationResponse.T := (
                                                       messagetypeid => 3,
                                                       messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                       currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                       interval => 300,
                                                       status => RegistrationStatusEnumType.Rejected);
      
      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
   begin
      result := false;
      bootNotificationRequest.To_Bounded_String(packet);
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);
      
      expectedresponse.To_Bounded_String(packet);
      
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(packet)) then
         Put_line("Success");
      else
         Put_line("Error: 234");
         return;
      end if;
      
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);     
      expectedresponse.status := RegistrationStatusEnumType.Accepted;
      
      Put_line("Receiving:");
      bootNotificationRequest.To_Bounded_String(packet);
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);
      
      expectedresponse.To_Bounded_String(packet);
      Put_line("expected response:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(packet)) then
         Put_line("Success");
      else
         Put_line("Error: 497");
         return;
      end if;

      result := true;
      
   end B03;     
   
   procedure B04(result: out Boolean)
   is
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("B030001");
      valid: Boolean;
      heartbeatRequest: ocpp.heartbeatRequest.T := (
                                       messagetypeid => 2,
                                       messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                       action => action_t.To_Bounded_String("Heartbeat"),
                                       unused => -1
                                                   );
      heartbeatResponse: ocpp.HeartbeatResponse.T := (
                                                      messagetypeid => 3,
                                                      messageid => heartbeatRequest.messageid,
                                                      currentTime => NonSparkTypes.HeartbeatResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z")                                                      
                                                     );
      
      
      bootNotificationRequest: ocpp.BootNotificationRequest.T := (
                                              messagetypeid => 2,
                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                              action => action_t.To_Bounded_String("BootNotification"),
                                              reason => BootReasonEnumType.PowerUp,
                                              chargingStation => (
                                                                  zzzArrayElementInitialized => False,
                                                                  serialNumber => sn,
                                                                  model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                  vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                  firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                  modem => (
                                                                            zzzArrayElementInitialized => False,
                                                                            iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                            imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                           )
                                                                 )                                                 
                                             );

      bootNotificationResponse: ocpp.BootNotificationResponse.T := (
                                                       messagetypeid => 3,
                                                       messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                       currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                       interval => 300,
                                                       status => RegistrationStatusEnumType.Accepted);
      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;
   begin
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);     
      bootNotificationRequest.To_Bounded_String(packet);
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);

      Put_line("expected response:");
      bootNotificationResponse.To_Bounded_String(expectedresponse);
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 81");
         return;
      end if;

      heartbeatRequest.To_Bounded_String(packet);           
      Put_line("Receiving:");
      Put_Line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, valid);
      Put_line("expected response:");
      heartbeatResponse.To_Bounded_String(expectedresponse);
      Put_Line(NonSparkTypes.packet.To_String(expectedresponse));
      Put_line("Sending:");
      Put_Line(NonSparkTypes.packet.To_String(response));

      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 637");
         return;
      end if;
      
      result := true;
   end B04;
   
   procedure B05(result: out Boolean)
   is
      use ocpp.SetVariablesResponse;
      --use ocpp.SetVariablesRequest.DataType;

      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      valid: Boolean;
      bootNotificationRequest: ocpp.BootNotificationRequest.T := (
                                              messagetypeid => 2,
                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                              action => action_t.To_Bounded_String("BootNotification"),
                                              reason => BootReasonEnumType.PowerUp,
                                              chargingStation => (
                                                                  zzzArrayElementInitialized => False,
                                                                  serialNumber => sn,
                                                                  model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                  vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                  firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                  modem => (
                                                                            zzzArrayElementInitialized => False,
                                                                            iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                            imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                           )
                                                                 )                                                 
                                             );
      bootNotificationResponse: ocpp.BootNotificationResponse.T := (
                                                       messagetypeid => 3,
                                                       messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                       currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                       interval => 300,
                                                       status => RegistrationStatusEnumType.Accepted);

      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;

      strServerPacket: NonSparkTypes.packet.Bounded_String;
      strTestPacket: NonSparkTypes.packet.Bounded_String;
      
      expectedresponse: NonSparkTypes.packet.Bounded_String;

      setVariablesRequest : ocpp.SetVariablesRequest.T := (
                                                           messagetypeid => 2,
                                                           messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                           action => action_t.To_Bounded_String("SetVariables"),
                                                           setVariableData => 
                                                             ( content => 
                                                                 ( 1 => 
                                                                       (
                                                                        zzzArrayElementInitialized => True,
                                                                        attributeType => AttributeEnumType.Actual,
                                                                        attributeValue => NonSparkTypes.SetVariableDataType.strattributeValue_t.To_Bounded_String("p@ssw0rd"),
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
                                                                   others => 
                                                                     (
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
                                                                     )
                                                                  )
                                                              )
                                                          );
      
      setVariablesResponse : ocpp.SetVariablesResponse.T := (
                                                             messagetypeid => 3,
                                                             messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                             setVariableResult => ( content => (
                                                                                                1 => 
                                                                                                  (
                                                                                                   zzzArrayElementInitialized => True,
                                                                                                   attributeType => AttributeEnumType.Actual,
                                                                                                   attributeStatus => ocpp.SetVariableStatusEnumType.Accepted,
                                                                                                   component => (
                                                                                                                 zzzArrayElementInitialized => True,
                                                                                                                 name => NonSparkTypes.ComponentType.strname_t.To_Bounded_String("name001"),
                                                                                                                 instance => NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String("instance001"),
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
                                                                                                others => 
                                                                                                  (
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
                                                                  
                                                                                               
                                                                                               )
                                                                                   )
                                                            );
   begin
      Put_line("Test B05");
      result := false;
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);     

      ocpp.BootNotificationRequest.To_Bounded_String(bootNotificationRequest, packet);      
      server.ReceivePacket(packet, response, valid);
      bootNotificationResponse.To_Bounded_String(expectedresponse);
      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 663");
         return;
      end if;
      
      ocpp.setvariablesRequest.To_Bounded_String(setVariablesRequest, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      
      ocpp.server.SendRequest(server, setVariablesRequest);
      ocpp.SetVariablesResponse.To_Bounded_String(setVariablesResponse, packet);
      put_line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, result);

      ocpp.SetVariablesResponse.To_Bounded_String(server.setVariablesResponse, strServerPacket);
      ocpp.SetVariablesResponse.To_Bounded_String(setVariablesResponse, strTestPacket);
      if (strServerPacket = strTestPacket)
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
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      valid: Boolean;
      dummystring: NonSparkTypes.packet.Bounded_String;
      bootNotificationRequest: ocpp.BootNotificationRequest.T := (
                                              messagetypeid => 2,
                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                              action => action_t.To_Bounded_String("BootNotification"),
                                              reason => BootReasonEnumType.PowerUp,
                                              chargingStation => (
                                                                  zzzArrayElementInitialized => False,
                                                                  serialNumber => sn,
                                                                  model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                  vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                  firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                  modem => (
                                                                            zzzArrayElementInitialized => False,
                                                                            iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                            imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
                                                                           )
                                                                 )                                                 
                                             );

      bootNotificationResponse: ocpp.BootNotificationResponse.T := (
                                                       messagetypeid => 3,
                                                       messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                                       currentTime => NonSparkTypes.BootNotificationResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z"),
                                                       interval => 300,
                                                       status => RegistrationStatusEnumType.Accepted);

      packet: NonSparkTypes.packet.Bounded_String;
      strServerPacket: NonSparkTypes.packet.Bounded_String;
      strTestPacket: NonSparkTypes.packet.Bounded_String;
      
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;

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
      ocpp.server.EnrolChargingStation(server.enrolledChargers, sn, result);     

      ocpp.BootNotificationRequest.To_Bounded_String(bootNotificationRequest, packet);      
      server.ReceivePacket(packet, response, valid);
      bootNotificationResponse.To_Bounded_String(expectedresponse);
      if (NonSparkTypes.packet.To_String(response) = NonSparkTypes.packet.To_String(expectedresponse)) then
         Put_line("Success");
      else
         Put_line("Error: 765");
         return;
      end if;
      
      ocpp.GetVariablesRequest.To_Bounded_String(getVariablesRequest, packet);
      NonSparkTypes.put_line("sending:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      ocpp.server.SendRequest(server, getVariablesRequest);
      
      ocpp.GetVariablesResponse.To_Bounded_String(getVariablesResponse, packet);
      NonSparkTypes.put_line("receiving:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(packet));
      server.ReceivePacket(packet, response, result);
      if (result = false) then return; end if;
      
      NonSparkTypes.put_line("997");
      ocpp.GetVariablesResponse.To_Bounded_String(server.getVariablesResponse, strServerPacket);
      NonSparkTypes.put_line("999");
      ocpp.GetVariablesResponse.To_Bounded_String(getVariablesResponse, strTestPacket);
      NonSparkTypes.put_line("1001");
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
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      valid: Boolean;
      bnr: ocpp.BootNotificationRequest.T := (
                                              messagetypeid => 2,
                                              messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                              action => action_t.To_Bounded_String("BootNotification"),
                                              reason => BootReasonEnumType.PowerUp,
                                              chargingStation => (
                                                                  zzzArrayElementInitialized => False,
                                                                  serialNumber => sn,
                                                                  model => NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String("SingleSocketCharger"),
                                                                  vendorName => NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String("VendorX"),
                                                                  firmwareVersion => NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("01.23456789"),
                                                                  modem => (
                                                                            zzzArrayElementInitialized => False,
                                                                            iccid => ModemType.striccid_t.To_Bounded_String("01234567890123456789"),
                                                                            imsi => ModemType.strimsi_t.To_Bounded_String("01234567890123456789")
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
      
      server.ReceivePacket(dummystring, response, valid); 
      if (dummystring = expectedresponse) 
      then
         NonSparkTypes.put_line("B07 1 passed.");
      end if;
      
      ocpp.server.SendRequest(server, getBaseReportRequest);
      
      GetBaseReportResponse.To_Bounded_String(response);
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(response));
      server.ReceivePacket(response, dummystring, valid);
      
      result := valid;
   end B07;
   
      
   
     
end unittests;

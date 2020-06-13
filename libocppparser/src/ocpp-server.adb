pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with ocpp.RegistrationStatusEnumType; use ocpp.RegistrationStatusEnumType.string_t;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t; use NonSparkTypes.packet;
with ChargerList;

with ocpp.AuthorizeRequest;
with ocpp.AuthorizeResponse;
with ocpp.BootReasonEnumType;
with ocpp.BootNotificationRequest;
with ocpp.BootNotificationResponse;
with ocpp.GetBaseReportRequest;
with ocpp.GetBaseReportResponse;
with ocpp.HeartbeatRequest;
with ocpp.HeartbeatResponse;
with ocpp.SetVariablesRequest;
with ocpp.RegistrationStatusEnumType;
with ocpp.ResetRequest;
with ocpp.ResetResponse;
with ocpp.StatusNotificationRequest;
with ocpp.StatusNotificationResponse;

with BootNotificationResponseStrings;
with HeartbeatResponseStrings;

package body ocpp.server 
is
   procedure Initialize(self: out T)
   is
   begin
      NonSparkTypes.put_line("ocpp.server.initialize");
      self.enrolledChargers := ChargerList.vector_chargers.Empty_Vector;
      self.getBaseReportResponse.Initialize;
      self.getVariablesResponse.Initialize;
      self.isDeferringBootNotificationAccept := False;
      self.setVariablesResponse.Initialize;
      self.resetResponse.Initialize;
      self.call := NonSparkTypes.action_t.To_Bounded_String("");
   end Initialize;

   procedure EnrolChargingStation(theList: in out ChargerList.vecChargers_t;
                                  serialNumber: in ChargingStationTypeStrings.strserialNumber_t.Bounded_String;
                                  retval: out Boolean)
   is
   begin
      ChargerList.contains(theList, serialNumber, retval);      
      if (retval) then
         --if (theList.Contains(serialNumber)) then
         NonSparkTypes.put("ocpp.server.addChargingStation: already contains charger"); NonSparkTypes.put_line(ChargingStationTypeStrings.strserialNumber_t.To_String(serialNumber));
         retval := true;
         return;
      end if;

      ChargerList.append(theList, retval, serialNumber);
   end EnrolChargingStation;
   
   procedure IsEnrolled(theList: in ChargerList.vecChargers_t;
                        serialNumber: in ChargingStationTypeStrings.strserialNumber_t.Bounded_String;
                        retval: out Boolean)
   is
   begin
      ChargerList.contains(theList, serialNumber, retval);      
   end IsEnrolled;
   
   procedure SendRequest(theServer: in out ocpp.server.T;
                         msg: in call'Class)
   is
   begin
      NonSparkTypes.put_line("transmitting packet: ");
      theServer.call := msg.action;
   end SendRequest;
   
   procedure ReceivePacket(theServer: in out ocpp.server.T;
                           msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                           valid: out Boolean)
   is
      messageTypeId : Integer;
      index : Integer := 1;
   begin     
      response := NonSparkTypes.packet.To_Bounded_String("");
      ocpp.ParseMessageType(msg, messageTypeId, index, valid);
      
      if (valid = false)
      then
         return;
      end if;
      
      if (messageTypeId = 2) 
      then 
         HandleRequest(theServer, msg, index, response, valid);
      elsif (messageTypeId = 3)
      then
         HandleResponse(theServer, msg, index, valid);
      else
         valid := false;
      end if;
      
      if (index > NonSparkTypes.packet.Length(msg))
      then
         valid := false;
         return;
      end if;
      
      
   end ReceivePacket;
   
   procedure HandleRequest(theServer: in ocpp.server.T;
                           msg: in NonSparkTypes.packet.Bounded_String;
                           msgindex: in out Integer;
                           response: out NonSparkTypes.packet.Bounded_String;
                           valid: out Boolean)
   is
      action : NonSparkTypes.action_t.Bounded_String;
      msgid : NonSparkTypes.messageid_t.Bounded_String;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");
      
      ocpp.ParseMessageId(msg, msgid, msgindex,  valid);
      if (valid = false) then
         return;
      end if;
      
      if (NonSparkTypes.messageid_t.Length(msgid) = 0) then
         valid := false;
         return;
      end if;
      
      ocpp.ParseAction(msg, msgindex, action, valid); -- eg. "BootNotification"
      if (valid = false) then
         return;
      end if;

      if (action = ocpp.BootNotificationRequest.action)
      then
         HandleBootNotificationRequest(theServer, msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;

      elsif (action = ocpp.HeartbeatRequest.action)
      then
         HandleHeartbeatRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      elsif (action = ocpp.GetBaseReportRequest.action)
      then
         HandleGetBaseReportRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      elsif (action = ocpp.StatusNotificationRequest.action)
      then
         HandleStatusNotificationRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      elsif (action = ocpp.AuthorizeRequest.action)
      then
         HandleAuthorizeRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      else
         NonSparkTypes.put_line("ocpp-server: 103: ERROR: invalid action");
      end if;
      
      if (msgindex > NonSparkTypes.packet.Length(msg))
      then
         valid := false;
      end if;

      
   end HandleRequest;
   
   procedure HandleResponse(theServer: in out ocpp.server.T;
                            msg: in NonSparkTypes.packet.Bounded_String;
                            index: in out Integer;
                            valid: out Boolean)
   is
      
   begin
      NonSparkTypes.put_line("ocppServer: handleResponse");
      -- TODO - this is wrong, should check message ID, not theServer.call
      if (theServer.call = ocpp.SetVariablesRequest.action)
      then
         HandleSetVariablesResponse(theServer, msg, index, valid);
      elsif (theServer.call = ocpp.GetVariablesRequest.action)
      then
         HandleGetVariablesResponse(theServer, msg, index, valid);
      elsif (theServer.call = ocpp.GetBaseReportRequest.action)
      then
         HandleGetBaseReportResponse(theServer, msg, index, valid);
      elsif (theServer.call = ocpp.ResetRequest.action)
      then
         theServer.HandleResetResponse(msg, index, valid);
      else
         NonSparkTypes.put_line("ocpp-server.adb: 134: unknown response");
         NonSparkTypes.put("theServer.call: "); NonSparkTypes.put_line(NonSparkTypes.action_t.To_String(theServer.call)); 
         
         valid := false;
      end if;
      if (index > NonSparkTypes.packet.Length(msg))
      then
         valid := false;
         return;
      end if;
   end HandleResponse;
   
   procedure HandleSetVariablesResponse(theServer: in out ocpp.server.T;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : out Integer;
                                        valid: out Boolean)
   is
      setVariableResponse : SetVariablesResponse.T;
      
   begin
      ocpp.SetVariablesResponse.parse(msg, index, setVariableResponse, valid);
      if (valid = true)
      then
         theServer.setVariablesResponse := setVariableResponse;
      end if;
   end HandleSetVariablesResponse;

   procedure HandleGetBaseReportResponse(theServer: in out ocpp.server.T;
                                         msg: in NonSparkTypes.packet.Bounded_String;
                                         index : out Integer;
                                         valid: out Boolean)
   is
      getBaseReportResponse : ocpp.GetBaseReportResponse.T;
      
   begin
      ocpp.GetBaseReportResponse.parse(msg, index, getBaseReportResponse, valid);
      if (valid = true)
      then
         theServer.getBaseReportResponse := getBaseReportResponse;
      else
         valid := false;
      end if;
   end HandleGetBaseReportResponse;

   procedure HandleResetResponse(theServer: in out ocpp.server.T;
                                         msg: in NonSparkTypes.packet.Bounded_String;
                                         index : out Integer;
                                         valid: out Boolean)
   is
      resetResponse : ocpp.ResetResponse.T;
   begin
      ocpp.ResetResponse.parse(msg, index, resetResponse, valid);
      if (valid = true)
      then
         theServer.resetResponse := resetResponse;
      else
         valid := false;
      end if;
   end HandleResetResponse;

   procedure HandleGetVariablesResponse(theServer: in out ocpp.server.T;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : out Integer;
                                        valid: out Boolean)
   is
      getVariableResponse : GetVariablesResponse.T;
      
   begin
      NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse()");
      ocpp.GetVariablesResponse.parse(msg, index, getVariableResponse, valid);
      if (valid = true) then
         NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse(): 193: good packet");
         theServer.getVariablesResponse := getVariableResponse;
      else
         NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse(): 196: bad packet");
      end if;
   end HandleGetVariablesResponse;


   procedure HandleBootNotificationRequest(theServer: in ocpp.server.T;
                                           msg: in NonSparkTypes.packet.Bounded_String;
                                           index : out Integer;
                                           valid: out Boolean;
                                           response: out NonSparkTypes.packet.Bounded_String
                                          )
   is
      bootNotificationRequest : ocpp.BootNotificationRequest.T;
      bootNotificationResponse : ocpp.bootnotificationResponse.T;
      isChargerEnrolled : Boolean;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");

      ocpp.BootNotificationRequest.parse(msg, index, bootNotificationRequest, valid);
      if (valid = False)
      then
         NonSparkTypes.put_line("ocpp-server: 76: invalid packet");
         return;
      end if;
      
      bootNotificationResponse.messagetypeid := 3;
      pragma assert (bootNotificationResponse.messagetypeid = 3);
          
      bootNotificationResponse.messageid := bootNotificationRequest.messageid;
      bootNotificationResponse.currentTime := BootNotificationResponseStrings.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z");
      bootNotificationResponse.interval := 300;
         
      IsEnrolled(theServer.enrolledChargers, bootNotificationRequest.chargingStation.serialNumber, isChargerEnrolled);
         
      if (isChargerEnrolled) then
         if (theServer.isDeferringBootNotificationAccept) then
            bootNotificationResponse.status := RegistrationStatusEnumType.Pending;
         else
            bootNotificationResponse.status := RegistrationStatusEnumType.Accepted;
         end if;
      else
         bootNotificationResponse.status := RegistrationStatusEnumType.Rejected;
      end if;
         
      bootNotificationResponse.To_Bounded_String(response);      
   end HandleBootNotificationRequest;
   
   procedure HandleHeartbeatRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String
                                   )
   is
      heartbeatRequest : ocpp.heartbeatRequest.T;
      heartbeatResponse : ocpp.heartbeatResponse.T;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");
      
      ocpp.HeartbeatRequest.parse(msg, index, heartbeatRequest, valid);
      
      if (valid = false) then
         NonSparkTypes.put_line("ocpp-server: 156: invalid heartbeat packet");
         return;
      end if;
      
      heartbeatResponse.messagetypeid := 3;
      heartbeatResponse.messageid := heartbeatRequest.messageid;
      heartbeatResponse.currentTime := HeartbeatResponseStrings.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z");
      heartbeatResponse.To_Bounded_String(response);
      NonSparkTypes.put("ocpp-server: 137: response:"); NonSparkTypes.put_line(NonSparkTypes.packet.To_String(response));
   end HandleHeartbeatRequest;
   
   procedure HandleGetBaseReportRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                        index : in out Integer;
                                        valid: out Boolean;
                                        response: out NonSparkTypes.packet.Bounded_String
                                       )
   is
      getBaseReportRequest : ocpp.GetBaseReportRequest.T;
      dummyBounded : NonSparkTypes.packet.Bounded_String;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");
      
      ocpp.GetBaseReportRequest.parse(msg, index, getBaseReportRequest, valid);
      
      if (valid = false) then
         NonSparkTypes.put_line("ocpp-server: 258: invalid GetBaseReportRequest");
         return;
      end if;
      
      NonSparkTypes.put_line("I am a server, I should be sending this packet, not receiving it!");
      GetBaseReportRequest.To_Bounded_String(dummyBounded);
      response := dummyBounded;
      valid := false;
      
   end HandleGetBaseReportRequest;
   
   procedure HandleStatusNotificationRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                             index : in out Integer;
                                             valid: out Boolean;
                                             response: out NonSparkTypes.packet.Bounded_String
                                            )
   is
      statusNotificationRequest : ocpp.StatusNotificationRequest.T;
      statusNotificationResponse : ocpp.StatusNotificationResponse.T;
      dummyBounded : NonSparkTypes.packet.Bounded_String;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");
      statusNotificationResponse.Initialize;
      ocpp.StatusNotificationRequest.parse(msg, index, statusNotificationRequest, valid);
      
      if (valid = false) then
         NonSparkTypes.put_line("ocpp-server: 258: invalid StatusNotificationRequest");
         return;
      end if;
      
      statusNotificationResponse.messagetypeid := 3;
      statusNotificationResponse.messageid := statusNotificationRequest.messageid;
      
      statusNotificationResponse.To_Bounded_String(response);
      valid := true;
      
   end HandleStatusNotificationRequest;


   procedure HandleAuthorizeRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                             index : in out Integer;
                                             valid: out Boolean;
                                             response: out NonSparkTypes.packet.Bounded_String
                                            )
   is
      authorizeRequest : ocpp.AuthorizeRequest.T;
      authorizeResponse : ocpp.AuthorizeResponse.T;
      dummyBounded : NonSparkTypes.packet.Bounded_String;
   begin
      response := NonSparkTypes.packet.To_Bounded_String("");
      authorizeResponse.Initialize;
      ocpp.AuthorizeRequest.parse(msg, index, authorizeRequest, valid);
      
      if (valid = false) then
         NonSparkTypes.put_line("ocpp-server: 423: invalid AuthorizeRequest");
         return;
      end if;
      
      authorizeResponse.messagetypeid := 3;
      authorizeResponse.messageid := authorizeRequest.messageid;
      
      authorizeResponse.To_Bounded_String(response);
      valid := true;
      
   end HandleAuthorizeRequest;

end ocpp.server;

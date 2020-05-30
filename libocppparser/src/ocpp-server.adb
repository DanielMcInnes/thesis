pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with ocpp.RegistrationStatusEnumType; use ocpp.RegistrationStatusEnumType.string_t;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.messageid_t; use NonSparkTypes.packet;
with ChargerList;

with ocpp.BootReasonEnumType;
with ocpp.BootNotificationRequest;
with ocpp.BootNotificationResponse;
with ocpp.GetBaseReportRequest;
with ocpp.GetBaseReportResponse;
with ocpp.SetVariablesRequest;
with ocpp.RegistrationStatusEnumType;
with ocpp.StatusNotificationRequest;
with ocpp.StatusNotificationResponse;

with ocpp.HeartbeatRequest;
with ocpp.HeartbeatResponse;

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
      self.call := NonSparkTypes.action_t.To_Bounded_String("");
   end Initialize;

   procedure enrolChargingStation(theList: in out ChargerList.vecChargers_t;
                                  serialNumber: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
                                  retval: out Boolean)
   is
   begin
      ChargerList.contains(theList, serialNumber, retval);      
      if (retval) then
         --if (theList.Contains(serialNumber)) then
         NonSparkTypes.put("ocpp.server.addChargingStation: already contains charger"); NonSparkTypes.put_line(NonSparkTypes.ChargingStationType.strserialNumber_t.To_String(serialNumber));
         retval := true;
         return;
      end if;

      ChargerList.append(theList, retval, serialNumber);
   end enrolChargingStation;
   
   procedure isEnrolled(theList: in ChargerList.vecChargers_t;
                        serialNumber: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
                        retval: out Boolean)
   is
   begin
      ChargerList.contains(theList, serialNumber, retval);      
      NonSparkTypes.put("ocpp.server.isEnrolled: "); NonSparkTypes.put(serialNumber); NonSparkTypes.put(retval'Image); --NonSparkTypes.put_line(enrolledChargers.Length'Image);
   end isEnrolled;
   
   procedure sendRequest(theServer: in out ocpp.server.T;
                         msg: in call'Class)
   is
   begin
      NonSparkTypes.put_line("transmitting packet: ");
      theServer.call := msg.action;
   end sendRequest;
   
   procedure receivePacket(theServer: in out ocpp.server.T;
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
         handleRequest(theServer, msg, index, response, valid);
      elsif (messageTypeId = 3)
      then
         handleResponse(theServer, msg, index, valid);
      else
         valid := false;
      end if;
      
      if (index > NonSparkTypes.packet.Length(msg))
      then
         valid := false;
         return;
      end if;
      
      
   end receivePacket;
   
   procedure handleRequest(theServer: in ocpp.server.T;
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
         handleBootNotificationRequest(theServer, msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;

      elsif (action = ocpp.HeartbeatRequest.action)
      then
         handleHeartbeatRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      elsif (action = ocpp.GetBaseReportRequest.action)
      then
         handleGetBaseReportRequest(msg, msgindex, valid, response);
         if (msgindex > NonSparkTypes.packet.Length(msg))
         then
            valid := false;
            return;
         end if;
      elsif (action = ocpp.StatusNotificationRequest.action)
      then
         handleStatusNotificationRequest(msg, msgindex, valid, response);
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

      
   end handleRequest;
   
   procedure handleResponse(theServer: in out ocpp.server.T;
                            msg: in NonSparkTypes.packet.Bounded_String;
                            index: in out Integer;
                            valid: out Boolean)
   is
      
   begin
      NonSparkTypes.put_line("ocppServer: handleResponse");
      if (theServer.call = ocpp.SetVariablesRequest.action)
      then
         handleSetVariablesResponse(theServer, msg, index, valid);
      elsif (theServer.call = ocpp.GetVariablesRequest.action)
      then
         handleGetVariablesResponse(theServer, msg, index, valid);
      elsif (theServer.call = ocpp.GetBaseReportRequest.action)
      then
         handleGetBaseReportResponse(theServer, msg, index, valid);
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
   end handleResponse;
   
   procedure handleSetVariablesResponse(theServer: in out ocpp.server.T;
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
   end handleSetVariablesResponse;

   procedure handleGetBaseReportResponse(theServer: in out ocpp.server.T;
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
   end handleGetBaseReportResponse;

   procedure handleGetVariablesResponse(theServer: in out ocpp.server.T;
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
   end handleGetVariablesResponse;


   procedure handleBootNotificationRequest(theServer: in ocpp.server.T;
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
      --pragma assert (bootNotificationResponse.messageid = bootNotificationRequest.messageid);

      bootNotificationResponse.currentTime := NonSparkTypes.bootnotificationresponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z");
      bootNotificationResponse.interval := 300;
         
      isEnrolled(theServer.enrolledChargers, bootNotificationRequest.chargingStation.serialNumber, isChargerEnrolled);
         
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
   end handleBootNotificationRequest;
   
   procedure handleHeartbeatRequest(msg: in NonSparkTypes.packet.Bounded_String;
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
      heartbeatResponse.currentTime := NonSparkTypes.HeartbeatResponse.strcurrentTime_t.To_Bounded_String("2013-02-01T20:53:32.486Z");
      heartbeatResponse.To_Bounded_String(response);
      NonSparkTypes.put("ocpp-server: 137: response:"); NonSparkTypes.put_line(NonSparkTypes.packet.To_String(response));
   end handleHeartbeatRequest;
   
   procedure handleGetBaseReportRequest(msg: in NonSparkTypes.packet.Bounded_String;
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
      
   end handleGetBaseReportRequest;
   
   procedure handleStatusNotificationRequest(msg: in NonSparkTypes.packet.Bounded_String;
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
      
   end handleStatusNotificationRequest;
end ocpp.server;

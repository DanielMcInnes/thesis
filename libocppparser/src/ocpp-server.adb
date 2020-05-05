--pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;

with NonSparkTypes; use NonSparkTypes.action_t;


with ocpp.BootNotification;
with ocpp.GetBaseReportRequest;
with ocpp.GetBaseReportResponse;
with ocpp.SetVariablesRequest;
with ocpp.StatusNotificationRequest;
with ocpp.StatusNotificationResponse;

with ocpp.heartbeat;

package body ocpp.server 
is
   procedure enrolChargingStation(theList: in out NonSparkTypes.vecChargers_t;
                                  serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                                  retval: out Boolean)
   is
   begin
      NonSparkTypes.contains(theList, serialNumber, retval);      
      if (retval) then
         --if (theList.Contains(serialNumber)) then
         NonSparkTypes.put("ocpp.server.addChargingStation: already contains charger"); NonSparkTypes.put_line(NonSparkTypes.ChargingStationType.serialNumber.To_String(serialNumber));
         retval := true;
         return;
      end if;

      NonSparkTypes.append(theList, serialNumber);
      
      retval := true;
   end enrolChargingStation;
   
   procedure isEnrolled(theList: in out NonSparkTypes.vecChargers_t;
                        serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                        retval: out Boolean)
   is
   begin
      NonSparkTypes.contains(theList, serialNumber, retval);      
      NonSparkTypes.put("ocpp.server.isEnrolled: "); NonSparkTypes.put(serialNumber); NonSparkTypes.put(retval'Image); --NonSparkTypes.put_line(enrolledChargers.Length'Image);
   end isEnrolled;
   
   procedure sendRequest(theServer: in out ocpp.server.Class;
                            msg: in call'Class)
   is
   begin
      NonSparkTypes.put_line("transmitting packet: ");
      theServer.call := msg.action;
   end sendRequest;
   
   procedure receivePacket(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
   is
      messageTypeId : Integer;
      index : Integer := 1;
   begin     
      valid := false;
      response := NonSparkTypes.packet.To_Bounded_String("");
      ocpp.ParseMessageType(msg, messageTypeId, index, valid);
      if (messageTypeId = 2) 
      then 
         handleRequest(theServer, msg, response, valid);
      elsif (messageTypeId = 3)
      then
         handleResponse(theServer, msg, valid);
      end if;
      
   end receivePacket;
   
   procedure handleRequest(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
   is
      
      index : Integer := 1;
      messageId : NonSparkTypes.messageid_t.Bounded_String;
      action : NonSparkTypes.action_t.Bounded_String;
   begin
      
      ocpp.ParseMessageId(msg, messageId, index, valid); -- eg. "19223201"
      if (valid = false) then
         return;
      end if;
      
      ocpp.ParseAction(msg, index, action, valid); -- eg. "BootNotification"
      if (valid = false) then
         return;
      end if;

      if (action = ocpp.BootNotification.action)
      then
         handleBootNotification(theServer, msg, index, valid, response, 2, messageId, action);
      elsif (action = ocpp.heartbeat.action)
      then
         handleHeartbeat(theServer, msg, index, valid, response, 2, messageId, action);
      elsif (action = ocpp.GetBaseReportRequest.action)
      then
         handleGetBaseReportRequest(theServer, msg, index, valid, response, 2, messageId, action);
      elsif (action = ocpp.StatusNotificationRequest.action)
      then
         handleStatusNotificationRequest(theServer, msg, index, valid, response, 2, messageId, action);
      else
         NonSparkTypes.put_line("ocpp-server: 103: ERROR: invalid action");
      end if;
      
   end handleRequest;
   
   procedure handleResponse(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
   is
      
      index : Integer := 1;
      messageId : NonSparkTypes.messageid_t.Bounded_String;
      action : NonSparkTypes.action_t.Bounded_String;
   begin
      NonSparkTypes.put_line("ocppServer: handleResponse");
      ocpp.ParseMessageId(msg, messageId, index, valid); -- eg. "19223201"
      if (valid = false) then
         return;
      end if;
      
      if (theServer.call = ocpp.SetVariablesRequest.action)
      then
         handleSetVariablesResponse(theServer, msg, index, valid, messageId);
      elsif (theServer.call = ocpp.GetVariablesRequest.action)
      then
         handleGetVariablesResponse(theServer, msg, index, valid, messageId);
      elsif (theServer.call = ocpp.GetBaseReportRequest.action)
      then
         handleGetBaseReportResponse(theServer, msg, index, valid, messageId);
      else
         NonSparkTypes.put_line("ocpp-server.adb: 134: unknown response"); valid := false;
         NonSparkTypes.put("theServer.call: "); NonSparkTypes.put_line(NonSparkTypes.action_t.To_String(theServer.call)); 
         
         valid := false;
      end if;
   end handleResponse;
   
   procedure handleSetVariablesResponse(theServer: in out ocpp.server.Class;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : in out Integer;
                                        valid: out Boolean;
                                        messageId : in NonSparkTypes.messageid_t.Bounded_String)
   is
      setVariableResponse : SetVariablesResponse.T;
      
   begin
      setVariableResponse.messagetypeid := 3;
      setVariableResponse.messageid := messageId;
      ocpp.SetVariablesResponse.parse(msg, index, setVariableResponse, valid);
      if (valid = true)
      then
         theServer.setVariablesResponse := setVariableResponse;
      end if;
   end handleSetVariablesResponse;

   procedure handleGetBaseReportResponse(theServer: in out ocpp.server.Class;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : in out Integer;
                                        valid: out Boolean;
                                        messageId : in NonSparkTypes.messageid_t.Bounded_String)
   is
      getBaseReportResponse : ocpp.GetBaseReportResponse.T;
      
   begin
      getBaseReportResponse.messagetypeid := 3;
      getBaseReportResponse.messageid := messageId;
      ocpp.GetBaseReportResponse.parse(msg, index, getBaseReportResponse, valid);
      if (valid = true)
      then
         theServer.getBaseReportResponse := getBaseReportResponse;
      else
         valid := false;
      end if;
   end handleGetBaseReportResponse;

   procedure handleGetVariablesResponse(theServer: in out ocpp.server.Class;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : in out Integer;
                                        valid: out Boolean;
                                        messageId : in NonSparkTypes.messageid_t.Bounded_String)
   is
      getVariableResponse : GetVariablesResponse.T;
      
   begin
      NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse()");
      getVariableResponse.messagetypeid := 3;
      getVariableResponse.messageid := messageId;
      ocpp.GetVariablesResponse.parse(msg, index, getVariableResponse, valid);
      if (valid = true) then
         NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse(): 193: good packet");
         theServer.getVariablesResponse := getVariableResponse;
      else
         NonSparkTypes.put_line("ocppServer: handleGetVariablesResponse(): 196: bad packet");
      end if;
   end handleGetVariablesResponse;


   procedure handleBootNotification(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
   is
      bootNotificationRequest : ocpp.BootNotification.Request;
      bootNotificationResponse : ocpp.bootnotification.Response;
   begin
      ocpp.BootNotification.DefaultInitialize(bootNotificationRequest, messageTypeId, messageId, action);
      ocpp.BootNotification.parse(msg, index, bootNotificationRequest, valid);

      if (valid = true) then
         bootNotificationResponse.messagetypeid := 2;
         bootNotificationResponse.messageid := bootNotificationRequest.messageid;
         bootNotificationResponse.currentTime := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String("2013-02-01T20:53:32.486Z");
         bootNotificationResponse.interval := NonSparkTypes.bootnotification_t.response.interval.To_Bounded_String("300");
         
         isEnrolled(theServer.enrolledChargers, bootNotificationRequest.chargingStation.serialNumber, valid);
         
         if (valid) then
            if (theServer.isDeferringBootNotificationAccept) then
               bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Pending");
            else
               bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Accepted");
            end if;
         else
            bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Rejected");
         end if;
           
         toString(response, bootNotificationResponse);
      else
         NonSparkTypes.put_line("ocpp-server: 76: invalid packet");
      end if;
      
   end handleBootNotification;
   
   procedure handleHeartbeat(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
   is
      heartbeatRequest : ocpp.heartbeat.Request;
      heartbeatResponse : ocpp.heartbeat.Response;
   begin
      ocpp.heartbeat.DefaultInitialize(heartbeatRequest, messageTypeId, messageId, action);
      ocpp.heartbeat.parse(msg, index, heartbeatRequest, valid);
      
      if (valid = false) then
         NonSparkTypes.put_line("ocpp-server: 156: invalid heartbeat packet");
         return;
      end if;
      
      heartbeatResponse.messagetypeid := 3;
      heartbeatResponse.messageid := heartbeatRequest.messageid;
      heartbeatResponse.currentTime := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String("2013-02-01T20:53:32.486Z");
      toString(response, heartbeatResponse);
      NonSparkTypes.put("ocpp-server: 137: response:"); NonSparkTypes.put_line(NonSparkTypes.packet.To_String( response));
   end handleHeartbeat;
   
   procedure handleGetBaseReportRequest(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
   is
      getBaseReportRequest : ocpp.GetBaseReportRequest.T;
      dummyBounded : NonSparkTypes.packet.Bounded_String;
   begin
      getBaseReportRequest.messageid := messageId;
      getBaseReportRequest.action := action;
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
   
   procedure handleStatusNotificationRequest(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
   is
      statusNotificationRequest : ocpp.StatusNotificationRequest.T;
      statusNotificationResponse : ocpp.StatusNotificationResponse.T;
      dummyBounded : NonSparkTypes.packet.Bounded_String;
   begin
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
   

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response)
   is
   begin
      msg := NonSparkTypes.packet.To_Bounded_String("[3," & ASCII.LF
                                                    & '"'  &  NonSparkTypes.messageid_t.To_String(response.messageid)  & '"' & "," & ASCII.LF
                                                    & "{" & ASCII.LF
                                                    & "   " & '"' & "currentTime" & '"' & ": " & '"' & NonSparkTypes.bootnotification_t.response.currentTime.To_String(response.currentTime) & '"' & "," & ASCII.LF
                                                    & "   " &  '"' & "interval" & '"' & ": " & NonSparkTypes.bootnotification_t.response.interval.To_String(response.interval) & "," & ASCII.LF
                                                    & "   " & '"' & "status" & '"' & ": " & '"' & NonSparkTypes.bootnotification_t.response.status.To_String(response.status) & '"' & ASCII.LF
                                                    & "}" & ASCII.LF
                                                    & "]"
                                                   );
   end toString;

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.heartbeat.Response)
   is
   begin
      msg := NonSparkTypes.packet.To_Bounded_String("[3," & ASCII.LF
                                                    & '"'  &  NonSparkTypes.messageid_t.To_String(response.messageid)  & '"' & "," & ASCII.LF
                                                    & "{" & ASCII.LF
                                                    & "   " & '"' & "currentTime" & '"' & ": " & '"' & NonSparkTypes.bootnotification_t.response.currentTime.To_String(response.currentTime) & '"' & "," & ASCII.LF
                                                    & "}" & ASCII.LF
                                                    & "]"
                                                   );
   end toString;
end ocpp.server;

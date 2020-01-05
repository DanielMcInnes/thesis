--pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;

with NonSparkTypes; use NonSparkTypes.action_t;


with ocpp.BootNotification;
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
   
   procedure handle(theList: in out NonSparkTypes.vecChargers_t;
                    msg: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
   is
      valid : Boolean;
      index : Integer := 1;
      messageTypeId : Integer;
      messageId : NonSparkTypes.messageid_t.Bounded_String;
      action : NonSparkTypes.action_t.Bounded_String;
   begin     
      response := NonSparkTypes.packet.To_Bounded_String("");

      ocpp.ParseMessageType(msg, messageTypeId, index, valid);
      if (messageTypeId /= 2) then return; end if;
      
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
         handleBootNotification(theList, msg, index, valid, response, messageTypeId, messageId, action);
      elsif (action = ocpp.heartbeat.action)
      then
         handleHeartbeat(theList, msg, index, valid, response, messageTypeId, messageId, action);
      else
         NonSparkTypes.put_line("ocpp-server: ERROR: invalid action");
      end if;
      
   end handle;
   
   procedure handleBootNotification(theList: in out NonSparkTypes.vecChargers_t;
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
         
         isEnrolled(theList, bootNotificationRequest.chargingStation.serialNumber, valid);
         
         if (valid) then
            bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Accepted");
         else
            bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Rejected");
         end if;
           
         toString(response, bootNotificationResponse);
      else
         NonSparkTypes.put_line("ocpp-server: 76: invalid packet");
      end if;
      
   end handleBootNotification;
   
   procedure handleHeartbeat(theList: in out NonSparkTypes.vecChargers_t;
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

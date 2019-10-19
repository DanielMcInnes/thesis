pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;

with ocpp.BootNotification;

package body ocpp.server is
   
   procedure handle(request: in ocpp.packet.Bounded_String;
                    response: out ocpp.packet.Bounded_String)
   is
      valid : Boolean;
      bootNotificationRequest : ocpp.Request;
      bootNotificationResponse : ocpp.bootnotification.Response;
   begin
      
      response := ocpp.packet.To_Bounded_String("");

      ocpp.BootNotification.parse(request, bootNotificationRequest, valid);
      
      
      --[3,
      --"19223201",
      --{
      --"currentTime": "2013-02-01T20:53:32.486Z",
      --"interval": 300,
      --"status": "Accepted"
      --}
      --]      
      
      if (valid = true) then         
         bootNotificationResponse.messagetypeid := 2;
         bootNotificationResponse.messageid := bootNotificationRequest.messageid;
         bootNotificationResponse.currentTime := ocpp.bootnotification_t.response.currentTime.To_Bounded_String("2013-02-01T20:53:32.486Z");
         bootNotificationResponse.interval := ocpp.bootnotification_t.response.interval.To_Bounded_String("300");
         bootNotificationResponse.status := ocpp.bootnotification_t.response.status.To_Bounded_String("Accepted");
         toString(response, bootNotificationResponse);
      end if;
      
   end handle;
   
   procedure toString(msg: out ocpp.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response)
   is
   begin
      msg := ocpp.packet.To_Bounded_String("[3," & ASCII.LF
                                           & '"'  &  ocpp.messageid_t.To_String(response.messageid)  & '"' & "," & ASCII.LF
                                           & "{" & ASCII.LF
                                           & "   " & '"' & "currentTime" & '"' & ": " & '"' & ocpp.bootnotification_t.response.currentTime.To_String(response.currentTime) & '"' & "," & ASCII.LF
                                           & "   " &  '"' & "interval" & '"' & ": " & ocpp.bootnotification_t.response.interval.To_String(response.interval) & "," & ASCII.LF
                                           & "   " & '"' & "status" & '"' & ": " & '"' & ocpp.bootnotification_t.response.status.To_String(response.status) & '"' & ASCII.LF
                                           & "}" & ASCII.LF
                                           & "]"
                                          );
   end toString;
end ocpp.server;

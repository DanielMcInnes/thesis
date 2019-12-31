pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;

with NonSparkTypes;
with ocpp.BootNotification;

package body ocpp.server 
with
Refined_State => (State => enrolledChargers )
is
   -- the server maintains a list of charger ids that are allowed to connect
   use NonSparkTypes.vector_chargers;
      --enrolledChargers: NonSparkTypes.vector_chargers.Vector := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("");
      --enrolledChargers: vecChargers_t; -- := vecChargers_t.
   enrolledChargers : vecChargers_t := NonSparkTypes.vector_chargers.To_Vector(New_Item => NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String(""),
                                                                               Length => 0);
      
   
   procedure enrolChargingStation(serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                                retval: out Boolean)
   is
   begin
      NonSparkTypes.contains(enrolledChargers, serialNumber, retval);      
      if (retval) then
         NonSparkTypes.put("ocpp.server.addChargingStation: already contains charger"); NonSparkTypes.put_line(NonSparkTypes.ChargingStationType.serialNumber.To_String(serialNumber));
         retval := true;
         return;
      end if;

      NonSparkTypes.append(enrolledChargers, serialNumber);
      
      retval := true;
   end enrolChargingStation;
   
   procedure isEnrolled(
                        serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                        retval: out Boolean)
   is
   begin
      NonSparkTypes.contains(enrolledChargers, serialNumber, retval);      
      NonSparkTypes.put("ocpp.server.isEnrolled: "); NonSparkTypes.put(serialNumber); NonSparkTypes.put(retval'Image); --NonSparkTypes.put_line(enrolledChargers.Length'Image);
   end isEnrolled;
   
   procedure handle(request: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
   is
      valid : Boolean;
      bootNotificationRequest : ocpp.BootNotification.Request;
      bootNotificationResponse : ocpp.bootnotification.Response;
   begin
      
      response := NonSparkTypes.packet.To_Bounded_String("");

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
         bootNotificationResponse.currentTime := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String("2013-02-01T20:53:32.486Z");
         bootNotificationResponse.interval := NonSparkTypes.bootnotification_t.response.interval.To_Bounded_String("300");
         
         isEnrolled(bootNotificationRequest.chargingStation.serialNumber, valid);
         
         if (valid) then
            bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Accepted");
         else
            bootNotificationResponse.status := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String("Rejected");
         end if;
           
         toString(response, bootNotificationResponse);
      end if;
      
   end handle;
   
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
end ocpp.server;

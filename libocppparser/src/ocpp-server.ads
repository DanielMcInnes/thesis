pragma SPARK_Mode (On);

with ada.Containers.Bounded_Vectors;
with ada.Containers.Vectors;
with ada.Strings;
with ocpp;
with ocpp.BootNotification;

package ocpp.server is 
   --package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   type Class is tagged record
      -- the server maintains a list of charger ids that are allowed to connect
      reason: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); --eg. PowerUp
   end record;   

   procedure handle(request: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
     with
       Depends => (
                     response => request
                  );

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response);
                           
   
end ocpp.server;

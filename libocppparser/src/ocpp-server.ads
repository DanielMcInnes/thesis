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
      reason: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String(""); --eg. PowerUp
   end record;   

   procedure handle(request: in ocpp.packet.Bounded_String;
                   response: out ocpp.packet.Bounded_String)
     with Global => (in_out => Ada.Text_IO.File_System);

   procedure toString(msg: out ocpp.packet.Bounded_String;
                           response: in ocpp.BootNotification.Response);
                           
   
  end ocpp.server;

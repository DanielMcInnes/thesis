with Ada.Strings.Bounded;
package ocpp is  
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   messageId: Integer := 0;   --eg. 2, 3
   messageTypeId: Integer := 0; -- eg. 19223201
   action: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
end ocpp;

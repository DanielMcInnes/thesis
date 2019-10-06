with Ada.Strings.Bounded;
package ocpp is  
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   messageId: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String(""); 
   messageTypeId: Integer := 0; -- eg. 2, 3
   action: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");


   procedure single_char_to_int(intstring : in ocpp.packet.Bounded_String; 
                                retval : out Integer)
     with Pre     => ocpp.packet.Length(intstring) = 1;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Pre    => (if ocpp.packet.Length(msg) /= 0 then index <= ocpp.packet.Length(msg)),
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
       (if Last /= 0 then First <= ocpp.packet.Length(msg)),
       Global => null;

end ocpp;

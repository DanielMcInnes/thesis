pragma SPARK_Mode (On);

with Ada.Strings.Bounded;
with Ada.Text_IO;

package ocpp is  
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   procedure single_char_to_int(intstring : in ocpp.packet.Bounded_String; 
                                retval : out Integer)
     with Pre     => ocpp.packet.Length(intstring) = 1;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      Last   : out Natural)
     with
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then (index <= ocpp.packet.Length(msg))),
     Global => (In_Out => Ada.Text_IO.File_System);

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      First  : out Positive;
      Last   : out Natural)
     with
     Post => (Last <= ocpp.packet.Length(msg)) and 
     (Last < Integer'Last) and
     (if Last /= 0 then First <= ocpp.packet.Length(msg)) and
     (index <= ocpp.packet.Length(msg)),
     Global => null;

   procedure find_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Pre    => (if ocpp.packet.Length(msg) /= 0 then index <= ocpp.packet.Length(msg)),
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then First <= ocpp.packet.Length(msg)),
     Global => null;

end ocpp;

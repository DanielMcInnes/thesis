with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;

package ocpp is  
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   package messageid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package action_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   
   package bootnotification_t is

      package request is
         package reason is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package model is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package vendor is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
      end request;
      
      package response is
         package currentTime is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package interval is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package status is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
      end response;
      
   end bootnotification_t;
   
   
      
   
   currentTime: ocpp.BootNotification_t.request.reason.Bounded_String := ocpp.BootNotification_t.request.reason.To_Bounded_String(""); --eg. PowerUp
   interval:  ocpp.BootNotification_t.request.model.Bounded_String := ocpp.BootNotification_t.request.model.To_Bounded_String(""); -- eg. SingleSocketCharger
   status: ocpp.BootNotification_t.request.vendor.Bounded_String := ocpp.BootNotification_t.request.vendor.To_Bounded_String(""); -- eg. VendorX
   

   type call is tagged record
      messagetypeid : integer;-- eg. 2, 3
      messageid : messageid_t.Bounded_String; -- eg. 19223201
      action : action_t.Bounded_String;-- eg. BootNotification
   end record;
   
   type callresult is tagged record
      messagetypeid : integer;-- eg. 2, 3
      messageid : messageid_t.Bounded_String; -- eg. 19223201
   end record;
   
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
   
   generic
      type string_t (<>) is limited private;
      with function length (msg : string_t) return integer;
      with function element(msg : string_t; index: Positive) return character;
      with function to_string(msg : string_t) return string;        
   procedure findnonwhitespace(msg: in string_t;
                               index: in out Positive;
                               retval: out boolean);
   
   generic
      Max: Positive;
      type string_t (<>) is private;
      with function to_string(msg : string_t) return string;      
      with function To_Bounded_String(msg : string;
                                      Drop : Ada.Strings.Truncation := Ada.Strings.Error) return string_t;
      with function length (msg : string_t) return integer;
      
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: in out string_t) 
     with  Global => (In_Out => Ada.Text_IO.File_System);
end ocpp;

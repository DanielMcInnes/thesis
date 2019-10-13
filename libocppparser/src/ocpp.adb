with Ada.Text_IO; use Ada.Text_IO;
with ocpp;
with ada.strings.maps;

package body ocpp is

   procedure single_char_to_int(intstring : in ocpp.packet.Bounded_String;
                                retval : out Integer)
   is
   begin
      retval := Integer'Value(ocpp.packet.To_String(intstring));
   end single_char_to_int;

   procedure find_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in Positive;
      first  : out Positive;
      last   : out Natural)
   is
   begin
      put("    find_token: 22: index: "); put_line(index'image);
      put("    find_token: 23: token: "); put_line(token'Image);
      ocpp.packet.Find_Token(Source => msg,
                             Set => Ada.Strings.Maps.To_Set(token),
                             From => Integer(index),
                             First => Integer(first),
                             Test => Ada.Strings.Inside,
                             Last => last);
      if (last > ocpp.packet.Length(msg)) then
         last := 0;
         put("ERROR: move_index_past_token: 31: index: ");
         put (index'image);
         put(" length: ");
         put (ocpp.packet.Length(msg)'image);
         return;
      end if;

      put("    find_token: 30: index: "); put(index'image); put(" first: "); Put(first'image); put(" last: "); Put_Line(last'image);

   end find_token;

   procedure move_index_past_token
     (msg   : packet.Bounded_String;
      token : Character;
      index : in out Positive;
      last  : out Natural)
   is
      first  : Positive;
   begin
      find_token(msg, token, index, first, last);
      index := first + 1;
   end move_index_past_token;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      first  : out Positive;
      last   : out Natural)
   is
   begin
      find_token(msg, token, index, first, last);
      index := first + 1;
   end move_index_past_token;


   procedure findnonwhitespace(msg: in string_t;
                               index: in out Positive;
                               retval: out boolean) is
      temp : character;
   begin
      put("    findnonwhitespace 21: msg'size: "); put_line(msg'Size'Image);
      if ((index <= 0) or (index > Length(msg))) then
         retval := false;
         put("    findnonwhitespace 25: index: "); put_line("ERROR");
         return;
      end if;
           
      temp :=  Element(msg, index); put("    findnonwhitespace 27: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
      put("    findnonwhitespace 30: index: "); put_line(index'image);
      while ((temp = ASCII.LF) or (temp = ' ')) loop
         if (
             (index = Integer'Last)  or 
               (index >= Length(msg)) 
            ) 
         then
            retval := false; put("    findnonwhitespace 34: ERROR"); put(" packet: "); Put_Line(To_String(msg));
            return;
         end if;
         
         index := index + 1;
         if (index >= Length(msg))
         then
            retval := false; put("    findnonwhitespace 34: ERROR"); put(" packet: "); Put_Line(To_String(msg));
            return;
         end if;
         
         temp :=  Element(msg, index); put("    findnonwhitespace 41: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
         put("    13: index: "); put_line(index'image);
      end loop;      
      put("    findnonwhitespace 51: index: "); put_line(index'image);
      retval := true;
   end findnonwhitespace;

   procedure findnonwhitespace_packet is new findnonwhitespace(
                                                               string_t => ocpp.packet.Bounded_String, 
                                                               length => ocpp.packet.Length,
                                                               element => ocpp.packet.Element,
                                                               To_String => ocpp.packet.to_string
                                                              );
   
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: in out string_t)
   is
      tempPositive : Integer;
      first : Integer;
      second : Integer;
      tempbs : ocpp.packet.Bounded_String;      

   begin
      put("    117: index: "); put_line(index'image);
      findnonwhitespace_packet(msg, index, found);
      if (found = false) then
         return;
      end if;
      put("    120: index: "); put_line(index'image);

      if (index > ocpp.packet.Length(msg)) then return; end if;
      ocpp.move_index_past_token(msg, '"', index, first, tempPositive);
      if (tempPositive = 0) then put_line("121: ERROR"); found := false; return; end if;

      put("    133: index: "); put_line(index'image);

      if (index > ocpp.packet.Length(msg)) then return; end if;
      ocpp.move_index_past_token(msg, '"', index, second, tempPositive);

      if (tempPositive = 0) then
         put_line("138: ERROR");
         found := false;
         return;
      end if;

      if ((first + 1) > ocpp.packet.Length(msg)) then return; end if;
      tempbs := ocpp.packet.Bounded_Slice(msg, first + 1, second -1);
      put("    153: tempbs:"); Put_Line(ocpp.packet.To_String(tempbs));
      
      --put("max messageId length: "); put_line(ocpp.bootnotificationreason.Max_Length'Image);
      if (ocpp.packet.Length(tempbs) > Max ) then
         found := false;
         put_line("ERROR: "); put(" source length:"); put(ocpp.packet.Length(tempbs)'Image) ;put(" dest length: ");put(Length(foundString)'Image);
         return;
      end if;
      
          
      foundString := To_Bounded_String(ocpp.packet.To_String(tempbs));

      put("    146: tempstring: first: "); put(first'Image); put(" second: "); put(second'image); put(" foundString: "); put_line(To_String(foundString));
      found := true;
      index := second + 1;

   end findquotedstring;

end ocpp;

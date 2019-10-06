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




end ocpp;

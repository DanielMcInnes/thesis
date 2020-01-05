pragma SPARK_Mode (On);

with ocpp;
with ada.strings.maps;

package body ocpp is

   procedure findnextinteger(msg: in NonSparkTypes.packet.Bounded_String;
                             index : in out Positive;
                             foundInteger: out integer;
                             found : out Boolean) 
   is
      temp : character;
      last : integer;
   begin
      found := false;
      foundInteger := 0;
      if (index > NonSparkTypes.packet.Length(msg)) then
         found := false;
         NonSparkTypes.put("    20: index: "); NonSparkTypes.put_line("ERROR");
         return;
      end if;
           
      NonSparkTypes.packet.Find_Token(Source => msg,
                                      Set => Ada.Strings.Maps.To_Set("0123456789"),
                                      From => Integer(index),
                                      First => Integer(index),
                                      Test => Ada.Strings.Inside,
                                      Last => last);
      if (index > NonSparkTypes.packet.Length(msg) or index = 0)
      then
         found := false;
         return;
      end if;
      
      if (last > NonSparkTypes.packet.Length(msg)) then
         found := false;
         return;
      end if;
      
      
      temp := NonSparkTypes.packet.Element(msg, index);
      
      case temp is
         when '0' => foundInteger := 0;
         when '1' => foundInteger := 1;
         when '2' => foundInteger := 2;
         when '3' => foundInteger := 3;
         when '4' => foundInteger := 4;
         when '5' => foundInteger := 5;
         when '6' => foundInteger := 6;
         when '7' => foundInteger := 7;
         when '8' => foundInteger := 8;
         when '9' => foundInteger := 9;
         when others => return;              
      end case;
      
      found := true;
      
   end findnextinteger;
   
   procedure Initialize(Self : out ModemType_t)
   is
   begin
      self.iccid := NonSparkTypes.ModemType.iccid_t.To_Bounded_String("");
      self.imsi := NonSparkTypes.ModemType.imsi_t.To_Bounded_String("");
   end Initialize;
   
   procedure Initialize(Self : out ChargingStation_t) is
   begin
      self.serialNumber := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("");
      self.model := NonSparkTypes.ChargingStationType.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      self.vendorName := NonSparkTypes.ChargingStationType.vendorName.To_Bounded_String(""); -- eg. VendorX
      self.firmwareVersion := NonSparkTypes.ChargingStationType.firmwareVersion.To_Bounded_String("");
      Initialize(self.modem);
   end Initialize;

   procedure find_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in Positive;
      first  : out Positive;
      last   : out Natural)
   is
   begin
      --put("    find_token: 22: index: "); put_line(index'image);
      --put("    find_token: 23: token: "); put_line(token'Image);
      NonSparkTypes.packet.Find_Token(Source => msg,
                                      Set => Ada.Strings.Maps.To_Set(token),
                                      From => Integer(index),
                                      First => Integer(first),
                                      Test => Ada.Strings.Inside,
                                      Last => last);
      if (index > NonSparkTypes.packet.Length(msg))
      then
         last := 0;
         return;
      end if;
      
      if (first > NonSparkTypes.packet.Length(msg))
      then
         last := 0;
         return;
      end if;
      
      if (last > NonSparkTypes.packet.Length(msg)) then
         last := 0;
         --put("ERROR: move_index_past_token: 31: index: ");
         --put (index'image);
         NonSparkTypes.put(" length: ");
         NonSparkTypes.put (NonSparkTypes.packet.Length(msg)'image);
         return;
      end if;

      --put("    find_token: 30: index: "); put(index'image); put(" first: "); Put(first'image); put(" last: "); Put_Line(last'image);

   end find_token;

   procedure move_index_past_token
     (msg   : packet.Bounded_String;
      token : Character;
      index : in out Positive;
      last  : out Natural)
   is
      first  : Positive;
   begin
      last := 0;
      if (index >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      pragma assert(index < NonSparkTypes.packet.Length(msg)); 
      find_token(msg, token, index, first, last);

      if (first = Positive'Last)
      then
         last := 0;
         return;
      end if;
      index := first + 1;
      if (index >= NonSparkTypes.packet.Length(msg))
      then
         last := 0;
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      pragma assert(index < NonSparkTypes.packet.Length(msg)); 
   end move_index_past_token;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      first  : out Positive;
      last   : out Natural)
   is
   begin
      if (NonSparkTypes.packet.Length(msg) = 0)
      then
         first := 1;
         last := 0;
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;

      if (index > NonSparkTypes.packet.Length(msg))
      then
         first := 1;
         last := 0;
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      pragma assert(index <= NonSparkTypes.packet.Length(msg)); 

      find_token(msg, token, index, first, last);
      if (first = Positive'Last)
      then
         last := 0;
         return;
      end if;
      index := first + 1;
      
      if (index > NonSparkTypes.packet.Length(msg))
      then
         first := 1;
         last := 0;
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      pragma assert(index <= NonSparkTypes.packet.Length(msg)); 

   end move_index_past_token;


   procedure findnonwhitespace(msg: in string_t;
                               index: in out Positive;
                               retval: out boolean) is
      temp : character;
   begin
      --put("    findnonwhitespace 21: msg'size: "); put_line(msg'Size'Image);
      if ((index <= 0) or (index > Length(msg))) then
         retval := false;
         put("    findnonwhitespace 25: index: "); put_line("ERROR");
         return;
      end if;
           
      temp :=  Element(msg, index); --put("    findnonwhitespace 27: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
      --put("    findnonwhitespace 30: index: "); put_line(index'image);
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
         
         temp :=  Element(msg, index); --put("    findnonwhitespace 41: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
         --put("    13: index: "); put_line(index'image);
      end loop;      
      --put("    findnonwhitespace 51: index: "); put_line(index'image);
      retval := true;
   end findnonwhitespace;

   procedure findnonwhitespace_packet is new findnonwhitespace(
                                                               string_t => NonSparkTypes.packet.Bounded_String, 
                                                               length => NonSparkTypes.packet.Length,
                                                               element => NonSparkTypes.packet.Element,
                                                               To_String => NonSparkTypes.packet.to_string
                                                              );
   
   procedure findquotedstring(msg: in NonSparkTypes.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: in out string_t)
   is
      tempPositive : Integer;
      first : Integer;
      second : Integer;
      tempbs : NonSparkTypes.packet.Bounded_String;

   begin
      --put("    117: index: "); put_line(index'image);
      findnonwhitespace_packet(msg, index, found);
      if (found = false) then
         return;
      end if;
      --put("    120: index: "); put_line(index'image);

      if (index > NonSparkTypes.packet.Length(msg)) then return; end if;
      ocpp.move_index_past_token(msg, '"', index, first, tempPositive);
      if (tempPositive = 0) then found := false; return; end if;

      --put("    133: index: "); put_line(index'image);

      if (index > NonSparkTypes.packet.Length(msg)) then return; end if;
      ocpp.move_index_past_token(msg, '"', index, second, tempPositive);

      if (tempPositive = 0) then
         put_line("138: ERROR");
         found := false;
         return;
      end if;

      if ((first + 1) > NonSparkTypes.packet.Length(msg)) then return; end if;
      tempbs := NonSparkTypes.packet.Bounded_Slice(msg, first + 1, second -1);
      --put("    153: tempbs:"); Put_Line(NonSparkTypes.packet.To_String(tempbs));
      
      --put("max messageId length: "); put_line(ocpp.bootnotificationreason.Max_Length'Image);
      if (NonSparkTypes.packet.Length(tempbs) > Max ) then
         found := false;
         put_line("ERROR: "); put(" source length:"); put(NonSparkTypes.packet.Length(tempbs)'Image) ;put(" dest length: ");put(Length(foundString)'Image);
         return;
      end if;
      
          
      foundString := To_Bounded_String(NonSparkTypes.packet.To_String(tempbs));
      if (Length(foundString) = 0) then
         return;
      end if;
      

      --put("    146: tempstring: first: "); put(first'Image); put(" second: "); put(second'image); put(" foundString: "); put_line(To_String(foundString));
      
      found := true;
      index := second + 1;
      

   end findquotedstring;

   procedure findquotedstring_messageid is new findquotedstring(
                                                                Max => NonSparkTypes.messageid_t.Max_Length, 
                                                                string_t => NonSparkTypes.messageid_t.Bounded_String, 
                                                                length => NonSparkTypes.messageid_t.Length,
                                                                To_String => NonSparkTypes.messageid_t.to_string,
                                                                To_Bounded_String =>  NonSparkTypes.messageid_t.To_Bounded_String
                                                               );

   procedure findquotedstring_action is new findquotedstring(
                                                             Max => NonSparkTypes.action_t.Max_Length, 
                                                             string_t => NonSparkTypes.action_t.Bounded_String, 
                                                             length => NonSparkTypes.action_t.Length,
                                                             To_String => NonSparkTypes.action_t.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.action_t.To_Bounded_String
                                                            );

   procedure ParseMessageType(msg:   in  NonSparkTypes.packet.Bounded_String;
                            messagetypeid : out integer;-- eg. 2
                            index: in out Integer;
                            valid: out Boolean
                           )
   is
      tempPositive: integer;
      retval: boolean;
   begin
      valid:= false;
      messagetypeid := 0;
      if (index >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      if (index < 1)
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      ocpp.move_index_past_token(msg, '[', index, tempPositive); if (tempPositive = 0) then return; end if;
      
      findnextinteger(msg, index, messagetypeid, retval); if (retval = false) then return; end if;
      index := index + 1;
      --NonSparkTypes.put ("ocpp: GetMessageType: messageTypeId: "); NonSparkTypes.put_line(request.messageTypeId'image); 
      
      NonSparkTypes.put("ocpp: GetMessageType: 171 index: "); NonSparkTypes.put_line(index'image);
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      if (retval = false) then return; end if;
      valid := true;
   end ParseMessageType;
   
   procedure ParseMessageId(msg:   in  NonSparkTypes.packet.Bounded_String;
                            messageid : out NonSparkTypes.messageid_t.Bounded_String;
                            index: in out Integer;
                            valid: out Boolean
                         )
   is
      tempPositive: integer;
   begin
      valid:= false;
      messageid := NonSparkTypes.messageid_t.To_Bounded_String("");
      if (index >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;
      if (index < 1)
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(index'Image);
         return;
      end if;

      NonSparkTypes.put_line("ocpp: searching for messageId..."); 
      
      findquotedstring_messageid(msg, index, valid, messageid);      
      if (valid = false) then return; end if;
      if (NonSparkTypes.messageid_t.Length(messageid) > 0) then 
         valid := true;
         pragma assert(NonSparkTypes.messageid_t.Length(messageid) > 0); 
      end if;
      
      NonSparkTypes.put("parse: messageId: "); NonSparkTypes.put_Line(NonSparkTypes.messageid_t.To_String(messageid));
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;

      
   end ParseMessageId;
   
   procedure ParseAction(msg:   in  NonSparkTypes.packet.Bounded_String;
                            msgindex: in out Integer;
                            action : out NonSparkTypes.action_t.Bounded_String;
                            valid: out Boolean
                        )
   is
   begin
      action := NonSparkTypes.action_t.To_Bounded_String("");
      valid:= false;
      if (msgindex >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;
      if (msgindex < 1)
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;

      findquotedstring_action(msg, msgindex, valid, action);
      if (valid = false) then 
         NonSparkTypes.put_line("parseAction: Error: 400"); 
         return; 
      end if;
      
      NonSparkTypes.put("parse: action: "); NonSparkTypes.put_Line(NonSparkTypes.action_t.To_String(action));
      
      
   end ParseAction;
   
     


end ocpp;

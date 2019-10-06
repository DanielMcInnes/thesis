pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Maps;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotifications;

package body ocpp.BootNotifications is

   procedure findnonwhitespace(msg: in ocpp.packet.Bounded_String;
                               index: in out Positive;
                               retval: out boolean)
     --with pre => msg'size = ocpp.packet.Bounded_String'Size and index < 500--msg'size
   is
      temp : character;
   begin
      put("    findnonwhitespace 19: msg'size: "); put_line(msg'Size'Image);
      --put("18: msg'size: "); put_line(msg. );
      if ((index <= 0) or (index > ocpp.packet.Length(msg))) then
         retval := false;
         put("    findnonwhitespace 23: index: "); put_line("ERROR");
         return;
      end if;
           
      temp :=  ocpp.packet.Element(msg, index); put("    findnonwhitespace 27: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
      put("    13: index: "); put_line(index'image);
      while ((temp = ASCII.LF) or (temp = ' ')) loop
         if (
             (index = Integer'Last)  or 
               (index >= ocpp.packet.Length(msg)) 
            ) 
         then
            retval := false; put("    findnonwhitespace 34: ERROR"); put(" packet: "); Put_Line(ocpp.packet.To_String(msg));
            return;
         end if;
         
         index := index + 1;
         if (index >= ocpp.packet.Length(msg))
         then
            retval := false; put("    findnonwhitespace 34: ERROR"); put(" packet: "); Put_Line(ocpp.packet.To_String(msg));
            return;
         end if;
         
         temp :=  ocpp.packet.Element(msg, index); put("    findnonwhitespace 41: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
         put("    13: index: "); put_line(index'image);
      end loop;      
      put("    findnonwhitespace 20: index: "); put_line(index'image);
      retval := true;
   end findnonwhitespace;

   procedure findtoken(msg: in ocpp.packet.Bounded_String;
                       index : in out Positive;
                       found : out Boolean;
                       token: in Character) --with
   --     pre => index < msg'size,
   --     post => index < msg'size 
   is
      temp : character;
   begin
      put("    54: index: "); put(index'image); put(" looking for: "); put_line(token'image);
      --found := false;

      findnonwhitespace(msg, index, found);
      put("    58: index: "); put_line(index'image);
      
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         put("    20: index: "); put_line("ERROR");
         return;
      end if;

      --ocpp.packet.Find_Token(
      temp := ocpp.packet.Element(msg, index);
      --while (temp /= token) loop
      --end loop;
      
      Put("    found:"); put_line(temp'image);
      if (temp = token) then
         found := true;
      end if;
      
      index := index + 1;
      
   end findtoken;
   
   procedure findnextinteger(msg: in ocpp.packet.Bounded_String;
                             index : in out Positive;
                             foundInteger: out integer;
                             found : out Boolean) 
   is
      temp : character;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      foundInteger := 0;
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         put("    20: index: "); put_line("ERROR");
         return;
      end if;
           
      findnonwhitespace(msg, index, found);
      if (found = false) then
         return;
      end if;      
        
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         put("    110: "); put_line("ERROR");
         return;
      end if;
        
      temp :=  ocpp.packet.Element(msg, index);
      ocpp.packet.Append(intstring, temp);
      if (ocpp.packet.Length(intstring) /= 1) then
         found := false;
         put("    118: "); put_line("ERROR");
         return;
      else
         ocpp.single_char_to_int(intstring, foundInteger);
      found := true;
         
      end if;
      
   end findnextinteger;
   
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: out ocpp.packet.Bounded_String) is
      tempPositive : Positive;
      first : Positive;
      second : Positive;
      
   begin
      foundString := ocpp.packet.To_Bounded_String("");
      
      put("    117: index: "); put_line(index'image);
      findnonwhitespace(msg, index, found);
      if (found = false) then 
         return; 
      end if;
      put("    120: index: "); put_line(index'image);
      
      --if (index > ocpp.packet.Length(msg)) then return; end if;
      --ocpp.Find_Token(msg, '"', index, index, tempPositive);
      ocpp.packet.Find_Token(Source => msg, 
                             Set => Ada.Strings.Maps.To_Set('"'), 
                             From => index, 
                             First => first, 
                             Test => Inside,
                             Last => tempPositive);

      if (tempPositive = 0) then
         put_line("121: ERROR");
         found := false;
         return;
      end if;

      index := index + 1;
      put("    133: index: "); put_line(index'image);
      
      ocpp.packet.Find_Token(Source => msg, 
                             Set => Ada.Strings.Maps.To_Set('"'), 
                             From => index, 
                             First => second, 
                             Test => Inside,
                             Last => tempPositive);
      
      if (tempPositive = 0) then
         put_line("138: ERROR");
         found := false;
         return;
      end if;
      
      foundString := ocpp.packet.Bounded_Slice(msg, first + 1, second -1); put("    146: tempstring: first: "); put(first'Image); put(" second: "); put(second'image); put(" foundString: "); put_line(ocpp.packet.To_String(foundString));
      found := true;
      index := second + 1;

   end findquotedstring;
   
   function validreason(thereason: ocpp.packet.Bounded_String) return Boolean is
      bootreasons : constant BootReasons_t := (ocpp.packet.To_Bounded_String("ApplicationReset"),
                                               ocpp.packet.To_Bounded_String("FirmwareUpdate"),
                                               ocpp.packet.To_Bounded_String("LocalReset"),
                                               ocpp.packet.To_Bounded_String("PowerUp"),
                                               ocpp.packet.To_Bounded_String("RemoteReset"),
                                               ocpp.packet.To_Bounded_String("ScheduledReset"),
                                               ocpp.packet.To_Bounded_String("Triggered"),
                                               ocpp.packet.To_Bounded_String("Unknown"),
                                               ocpp.packet.To_Bounded_String("Watchdog"));
      --use all type ocpp.BootNotification.BootReasons_t;
   begin
      for I in bootreasons'Range loop
         --put(ocpp.packet.To_String(bootreasons(I)));
         if (ocpp.packet.To_String(bootreasons(I)) = ocpp.packet.To_String(thereason)) then 
            return true;
         end if;
      end loop;      
      return false;      
   end validreason;   
      
   procedure parse(msg: in ocpp.packet.Bounded_String;
                   bn: out ocpp.BootNotifications.BootNotification)
   is
      str : string := "reason";
      retval : boolean;
      --temp2: integer;
      dummybounded: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      index: Integer range 1 .. ocpp.packet.Max_Length := 1;
   begin
      bn.reason := ocpp.packet.To_Bounded_String("");
      bn.model := ocpp.packet.To_Bounded_String("");
      bn.vendor := ocpp.packet.To_Bounded_String(""); --put("161 index: "); put_line(index'image);
      
      findtoken(msg, index, retval, '[');
      if (retval = false) then
         return;
      end if;
      
      put("169 index: "); put_line(index'image);

      findnextinteger(msg, index, messageTypeId, retval);
      put ("parse: messageTypeId: "); put_line(messageTypeId'image); 
      index := index + 1;

      put("parse: 171 index: "); put_line(index'image);
      if (retval = false) then return; end if;
      if (messageTypeId /= 2) then return; end if;

      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;

      put_line("parse: searching for messageId...");
      findquotedstring(msg, index, retval, messageId);
      if (retval = false) then return; end if;      
      put("parse: messageId: "); Put_Line(ocpp.packet.To_String(messageId));
      
      findtoken(msg,index,retval, ',');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, action);
      if (retval = false) then return; end if;
      put("parse: action: "); Put_Line(ocpp.packet.To_String(action));

      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;
            
      findtoken(msg, index, retval, '{');
      if (retval = false) then return; end if;

      put("parse: looking for 'reason': ");
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then 
         put("parse: ERROR: looking for 'reason': ");
         return; 
      end if;
      
      put("parse: found: "); Put_Line(ocpp.packet.To_String(dummybounded));
      put_line(ocpp.packet.To_String(dummybounded));
      if (ocpp.packet.To_String(dummybounded) /= str) then 
         put("parse: 243: ERROR: looking for 'reason': ");
         put("comparing with: "); put_line(str);
         return; 
      end if;

      put("parse: 244: looking for ':' ");
      findtoken(msg, index, retval, ':');
      if (retval = false) then put("parse: 250: ERROR: looking for 'reason': ");        
         return; 
      end if;
      
      put("parse: looking for reason ");
      findquotedstring(msg, index, retval, bn.reason);
      if (retval = false) then 
         return; 
      end if;
      
      put("parse: reason: "); Put_Line(ocpp.packet.To_String(bn.reason));
      if (validreason(bn.reason) = false) then return; end if;
      
      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return; end if;
      
      findtoken(msg, index, retval, '{');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, bn.model);
      if (retval = false) then return; end if;
      put("parse: model: "); Put_Line(ocpp.packet.To_String(bn.model));
      
      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, bn.vendor);
      if (retval = false) then return; end if;
      put("parse: vendor: "); Put_Line(ocpp.packet.To_String(bn.vendor)); 
      put_Line(ocpp.packet.To_String(bn.vendor) );
      --str := ocpp.packet.To_String(bn.vendor);
      --put ((bn.vendor.length));
      --put_Line(ocpp.packet.To_String((bn.vendor.Length)));
                                                                                
      
      findtoken(msg, index, retval, '}');
      if (retval = false) then return; end if;
      
      findtoken(msg, index, retval, '}');
      if (retval = false) then return; end if;

      pragma Warnings (Off, "unused assignment",
                       Reason => "don't care");      
      findtoken(msg, index, retval, ']');      
      if (retval = false) then return; end if;
      pragma Warnings (On, "unused assignment");      
      --[2,
      --"19223201",
      --"BootNotification",
      --{
      --"reason": "PowerUp",
      --"chargingStation": {
      --"model": "SingleSocketCharger",
      --"vendorName": "VendorX"
      --}
      --}
      --]
      
      Put_Line("parse: hooray!"); 
      --put( ocpp.packet.Bounded_String'Max(bn.vendor));
      --Put(X.Length'Image);
      Put(ocpp.packet.Length(bn.vendor)'Image);
   end parse;
   

end ocpp.BootNotifications;

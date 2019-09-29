pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotifications;

package body ocpp.BootNotifications is

   procedure findnonwhitespace(msg: in ocpp.packet.Bounded_String;
                               index: in out Integer) is
      temp : character :=  ocpp.packet.Element(msg, index);
   begin
      put("13: index: "); put_line(index'image);
      while ((temp = ASCII.LF) or (temp = ' ')) loop
         index := index + 1;
         temp := ocpp.packet.Element(msg, index);
      end loop;      
      put("20: index: "); put_line(index'image);
   end findnonwhitespace;

   procedure findtoken(msg: in ocpp.packet.Bounded_String;
                       index : in out Integer;
                       found : out Boolean;
                       token: in Character) is
      temp : character := ' ';
   begin
      found := false;
      findnonwhitespace(msg, index);
      put("39: index: "); put_line(index'image);
      temp := ocpp.packet.Element(msg, index);
      Put("found:"); put_line(temp'image);
      if (temp = token) then
         found := true;
      end if;
      
      index := index + 1;
      
   end findtoken;
   
   procedure findinteger(msg: in ocpp.packet.Bounded_String;
                         index : in out Integer;
                         foundInteger: out integer;
                         found : out Boolean;
                         stopatthischar: character := '"') is
      temp : character := ' ';
      retval : Boolean := false;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      found := false;
      temp :=  ocpp.packet.Element(msg, index);
      put("63: index: "); put(index'image); put(" temp: "); put(temp'Image); put(" stopping at: "); put_line(stopatthischar'image);
      while (temp /= stopatthischar) loop
         ocpp.packet.Append(intstring, temp);
         index := index + 1;
         temp := ocpp.packet.Element(msg, index);
         put("68: index: "); put(index'image); put(" temp: "); put(temp'Image); put(" stopping at: "); put_line(stopatthischar'image);
         Put("69 found integer: "); Put_Line(ocpp.packet.To_String(intstring));
      end loop;      
      
      foundInteger := Integer'Value(ocpp.packet.To_String(intstring));
      found := true;
   end findinteger;
   
   procedure findquotedinteger(msg: in out ocpp.packet.Bounded_String;
                               index : in out Integer;
                               found : in out Boolean;
                               foundInteger: in out integer) is
      temp : character := ' ';
      tempindex : Integer := index;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin      
      findtoken(msg, index, found, '"');
      if (found = false) then
         return;
      end if;

      findinteger(msg, index, foundInteger, found );
      if (found = false) then
         return;
      end if;

      Put("111 found integer: "); Put_Line(foundInteger'Image);

      findtoken(msg, index, found, '"');
      if (found = false) then
         return;
      end if;
      
      found := true;
   end findquotedinteger;
      
   procedure findquotedstring(msg: in out ocpp.packet.Bounded_String;
                              index : in out Integer;
                              found : in out Boolean;
                              foundString: out ocpp.packet.Bounded_String) is
      temp : character := ' ';
      tempstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin      
      findtoken(msg, index, found, '"');
      if (found = false) then
         return;
      end if;

      temp :=  ocpp.packet.Element(msg, index);
      while (temp /= '"') loop
         ocpp.packet.Append(tempstring, temp);
         index := index + 1;
         temp := ocpp.packet.Element(msg, index);
         Put("1found: "); Put_Line(ocpp.packet.To_String(tempstring));
      end loop;      

      findtoken(msg, index, found, '"');
      if (found = false) then
         return;
      end if;
      
      foundString := tempstring;
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
         put(ocpp.packet.To_String(bootreasons(I)));
         if (ocpp.packet.To_String(bootreasons(I)) = ocpp.packet.To_String(thereason)) then 
            return true;
         end if;
      end loop;      
      return false;      
   end validreason;   
      
   function parse(self: ptr;
                  msg: in out ocpp.packet.Bounded_String) return Boolean     
   is
      temp : character :=  ocpp.packet.Element(msg, 1);
      str : string := "";
      retval : boolean := false;
      temp2: integer := 0;
      dummybounded: ocpp.packet.Bounded_String;
      bootreasons : BootReasons_t;
      index: Integer := 1;            
   begin
      put("161 index: "); put_line(index'image);
      
      findtoken(msg, index, retval, '[');
      if (retval = false) then
         return false;
      end if;
      
      put("169 index: "); put_line(index'image);

      findinteger(msg, index, messageTypeId, retval, ',');
      put("171 index: "); put_line(index'image);
      if (retval = false) then return false; end if;
      if (messageTypeId /= 2) then return false; end if;

      findtoken(msg, index, retval, ',');
      if (retval = false) then return false; end if;

      findquotedinteger(msg, index, retval, messageId);
      if (retval = false) then return false; end if;      
      put("messageId: "); Put_Line(messageId'Image);
      
      findtoken(msg,index,retval, ',');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, action);
      if (retval = false) then return false; end if;

      findtoken(msg, index, retval, ',');
      if (retval = false) then return false; end if;
            
      findtoken(msg, index, retval, '{');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "reason") then return false; end if;

      findtoken(msg, index, retval, ':');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, self.reason);
      if (retval = false) then return false; end if;
      put("reason: "); Put_Line(ocpp.packet.To_String(self.reason));
      if (validreason(self.reason) = false) then return false; end if;
      
      findtoken(msg, index, retval, ',');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return false; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return false; end if;
      
      findtoken(msg, index, retval, '{');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return false; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, self.model);
      if (retval = false) then return false; end if;
      put("model: "); Put_Line(ocpp.packet.To_String(self.model));
      
      findtoken(msg, index, retval, ',');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return false; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return false; end if;
      
      findquotedstring(msg, index, retval, self.vendor);
      if (retval = false) then return false; end if;
      put("vendor: "); Put_Line(ocpp.packet.To_String(self.vendor)); 
      put_Line(ocpp.packet.To_String(self.vendor) );
      --str := ocpp.packet.To_String(self.vendor);
      --put ((self.vendor.length));
      --put_Line(ocpp.packet.To_String((self.vendor.Length)));
                                                                                
      
      findtoken(msg, index, retval, '}');
      if (retval = false) then return false; end if;
      
      findtoken(msg, index, retval, '}');
      if (retval = false) then return false; end if;
      
      findtoken(msg, index, retval, ']');
      if (retval = false) then return false; end if;
      
      --   [2,
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
      
      Put_Line("hooray!"); 
      --put( ocpp.packet.Bounded_String'Max(self.vendor));
      --Put(X.Length'Image);
      Put(ocpp.packet.Length(self.vendor)'Image);
      return true;
   end parse;
   

end ocpp.BootNotifications;

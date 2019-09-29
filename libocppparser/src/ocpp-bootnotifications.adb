pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotifications;

package body ocpp.BootNotifications is

   procedure findnonwhitespace(msg: in ocpp.packet.Bounded_String;
                               index: in out Integer;
                               retval: out boolean) with
     pre => index < msg'size
   is
      temp : character;
   begin
      if ((index <= 0) or (index > ocpp.packet.Length(msg))) then
         retval := false;
         put("20: index: "); put_line("ERROR");
         return;
      end if;
           
      temp :=  ocpp.packet.Element(msg, index); put("24: index: "); put(index'Image); put(" temp: "); put_line(temp'image);
      put("13: index: "); put_line(index'image);
      while ((temp = ASCII.LF) or (temp = ' ')) loop
         if (index >= ocpp.packet.Length(msg)) then
            retval := false; put("28: ERROR"); put(" packet: "); Put_Line(ocpp.packet.To_String(msg));
            return;
         end if;
         
         pragma Loop_Invariant (index in msg'Size);
         index := index + 1;
         temp := ocpp.packet.Element(msg, index);
      end loop;      
      put("20: index: "); put_line(index'image);
      retval := true;
   end findnonwhitespace;

   procedure findtoken(msg: in ocpp.packet.Bounded_String;
                       index : in out Integer;
                       found : out Boolean;
                       token: in Character) is
      temp : character;
   begin
      put("45: index: "); put(index'image); put(" looking for: "); put_line(token'image);
      --found := false;
      findnonwhitespace(msg, index, found);
      put("48: index: "); put_line(index'image);
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
      temp : character;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      temp :=  ocpp.packet.Element(msg, index);
      while (temp /= stopatthischar) loop
         ocpp.packet.Append(intstring, temp);
         index := index + 1;
         temp := ocpp.packet.Element(msg, index);
      end loop;      
      
      foundInteger := Integer'Value(ocpp.packet.To_String(intstring));
      found := true;
   end findinteger;
   
   procedure findquotedinteger(msg: in ocpp.packet.Bounded_String;
                               index : in out Integer;
                               found : out Boolean;
                               foundInteger: in out integer) is
   begin
      findnonwhitespace(msg, index, found);
      if (found = false) then
         return;
      end if;



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
      
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Integer;
                              found : out Boolean;
                              foundString: out ocpp.packet.Bounded_String) is
      temp : character;
      tempstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      foundString := ocpp.packet.To_Bounded_String("");
      
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
      --str : string;
      retval : boolean;
      --temp2: integer;
      dummybounded: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      index: Integer range 1 .. ocpp.packet.Max_Length := 1;
   begin
      bn.reason := ocpp.packet.To_Bounded_String("");
      bn.model := ocpp.packet.To_Bounded_String("");
      bn.vendor := ocpp.packet.To_Bounded_String("");
      put("161 index: "); put_line(index'image);
      
      findtoken(msg, index, retval, '[');
      if (retval = false) then
         return;
      end if;
      
      put("169 index: "); put_line(index'image);

      findinteger(msg, index, messageTypeId, retval, ',');
      put ("messageTypeId: "); put_line(messageTypeId'image); 
      put("171 index: "); put_line(index'image);
      if (retval = false) then return; end if;
      if (messageTypeId /= 2) then return; end if;

      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;

      findquotedinteger(msg, index, retval, messageId);
      if (retval = false) then return; end if;      
      put("messageId: "); Put_Line(messageId'Image);
      
      findtoken(msg,index,retval, ',');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, action);
      if (retval = false) then return; end if;

      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;
            
      findtoken(msg, index, retval, '{');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "reason") then return; end if;

      findtoken(msg, index, retval, ':');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, bn.reason);
      if (retval = false) then return; end if;
      put("reason: "); Put_Line(ocpp.packet.To_String(bn.reason));
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
      put("model: "); Put_Line(ocpp.packet.To_String(bn.model));
      
      findtoken(msg, index, retval, ',');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      findtoken(msg, index, retval, ':');
      if (retval = false) then return; end if;
      
      findquotedstring(msg, index, retval, bn.vendor);
      if (retval = false) then return; end if;
      put("vendor: "); Put_Line(ocpp.packet.To_String(bn.vendor)); 
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
      --put( ocpp.packet.Bounded_String'Max(bn.vendor));
      --Put(X.Length'Image);
      Put(ocpp.packet.Length(bn.vendor)'Image);
   end parse;
   

end ocpp.BootNotifications;

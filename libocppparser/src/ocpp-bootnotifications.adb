pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotifications;

package body ocpp.BootNotifications is

   procedure trimlf(msg: out ocpp.packet.Bounded_String) is
      temp : character :=  ocpp.packet.Element(msg, 1);
   begin
      while ((temp = ASCII.LF) or (temp = ' ')) loop
         ocpp.packet.Delete(msg, 1, 1);
         temp := ocpp.packet.Element(msg, 1);
      end loop;      
   end trimlf;

   function consumetoken(msg: out ocpp.packet.Bounded_String;
                         token: in Character) return Boolean is
      temp : character := ' ';
      retval : Boolean := false;
   begin      
      trimlf(msg);
      temp := ocpp.packet.Element(msg, 1);
      Put_Line("found:"); put(temp); put_line("");
      if (temp = token) then
         retval := true;
      end if;
      ocpp.packet.Delete(msg, 1, 1);      
      Put_Line("retval:"); put(retval'image); put_line("");
      return retval;      
   end consumetoken;
   
   function consumeinteger(msg: out ocpp.packet.Bounded_String;
                           consumedInteger: out integer;
                           stopatthischar: character := '"') return Boolean is
      temp : character := ' ';
      retval : Boolean := false;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin      
      temp :=  ocpp.packet.Element(msg, 1);
      while (temp /= stopatthischar) loop
         ocpp.packet.Append(intstring, temp);
         ocpp.packet.Delete(msg, 1, 1);
         temp := ocpp.packet.Element(msg, 1);
         Put("1found integer: "); Put_Line(ocpp.packet.To_String(intstring));
      end loop;      
      
      consumedInteger := Integer'Value(ocpp.packet.To_String(intstring));
      return true;
   end consumeinteger;
   
   function consumequotedinteger(msg: out ocpp.packet.Bounded_String;
                                 consumedInteger: out integer) return Boolean is
      temp : character := ' ';
      retval : Boolean := false;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin      
      retval := consumetoken(msg, '"');
      if (retval = false) then
         return false;
      end if;

      retval := consumeinteger(msg, consumedInteger);
      if (retval = false) then
         return false;
      end if;

      Put("111 found integer: "); Put_Line(consumedInteger'Image);

      retval := consumetoken(msg, '"');
      if (retval = false) then
         return false;
      end if;
      
      return true;
   end consumequotedinteger;
      
   function consumequotedstring(msg: out ocpp.packet.Bounded_String;
                                consumedString: out ocpp.packet.Bounded_String) return Boolean is
      temp : character := ' ';
      retval : Boolean := false;
      tempstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin      
      retval := consumetoken(msg, '"');
      if (retval = false) then
         return false;
      end if;

      temp :=  ocpp.packet.Element(msg, 1);
      while (temp /= '"') loop
         ocpp.packet.Append(tempstring, temp);
         ocpp.packet.Delete(msg, 1, 1);
         temp := ocpp.packet.Element(msg, 1);
         Put("1found: "); Put_Line(ocpp.packet.To_String(tempstring));
      end loop;      

      retval := consumetoken(msg, '"');
      if (retval = false) then
         return false;
      end if;
      
      consumedString := tempstring;
      return true;
   end consumequotedstring;
   
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
                  msg: in out ocpp.packet.Bounded_String) return Boolean is
      temp : character :=  ocpp.packet.Element(msg, 1);
      str : string := "";
      retval : boolean := false;
      temp2: integer := 0;
      --br2 : BootNotification.br.Bounded_String := br.To_Bounded_String("aaa");
      dummybounded: ocpp.packet.Bounded_String;
      bootreasons : BootReasons_t;
      --p : packet_ptr := aliased self.vendor;

            
      package SB is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 50);
      X : SB.Bounded_String := SB.To_Bounded_String("blah");
      --bootreasons := br.To_Bounded_String("aaa"), br.To_Bounded_String("aaa"),               br.To_Bounded_String"aaa",                 br.To_Bounded_String"aaa",                 "aaa",                 "aaa",                   br.To_Bounded_String"aaa",                     br.To_Bounded_String"aaa",                     br.To_Bounded_String"aaa";      Put("parse: ");
      begin

      
      retval := consumetoken(msg, '[');
      if (retval = false) then
         return false;
      end if;
      
      retval := consumeinteger(msg, messageTypeId, ',');
      if (retval = false) then return false; end if;
      if (messageTypeId /= 2) then return false; end if;

      retval := consumetoken(msg, ',');
      if (retval = false) then return false; end if;

      retval := consumequotedinteger(msg, messageId);
      if (retval = false) then return false; end if;      
      put("messageId: "); Put_Line(messageId'Image);
      
      retval := consumetoken(msg, ',');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, action);
      if (retval = false) then return false; end if;

      retval := consumetoken(msg, ',');
      if (retval = false) then return false; end if;
            
      retval := consumetoken(msg, '{');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "reason") then return false; end if;

      retval := consumetoken(msg, ':');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, self.reason);
      if (retval = false) then return false; end if;
      put("reason: "); Put_Line(ocpp.packet.To_String(self.reason));
      if (validreason(self.reason) = false) then return false; end if;
      
      retval := consumetoken(msg, ',');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return false; end if;
      
      retval := consumetoken(msg, ':');
      if (retval = false) then return false; end if;
      
      retval := consumetoken(msg, '{');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return false; end if;
      
      retval := consumetoken(msg, ':');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, self.model);
      if (retval = false) then return false; end if;
      put("model: "); Put_Line(ocpp.packet.To_String(self.model));
      
      retval := consumetoken(msg, ',');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, dummybounded);
      if (retval = false) then return false; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return false; end if;
      
      retval := consumetoken(msg, ':');
      if (retval = false) then return false; end if;
      
      retval := consumequotedstring(msg, self.vendor);
      if (retval = false) then return false; end if;
      put("vendor: "); Put_Line(ocpp.packet.To_String(self.vendor)); 
      put_Line(ocpp.packet.To_String(self.vendor) );
      --str := ocpp.packet.To_String(self.vendor);
      --put ((self.vendor.length));
      --put_Line(ocpp.packet.To_String((self.vendor.Length)));
                                                                                
      
      retval := consumetoken(msg, '}');
      if (retval = false) then return false; end if;
      
      retval := consumetoken(msg, '}');
      if (retval = false) then return false; end if;
      
      retval := consumetoken(msg, ']');
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
      Put_Line (SB.To_String(X));
      --Put(X.Length'Image);
      Put(SB.Length(X)'Image);
      Put(ocpp.packet.Length(self.vendor)'Image);
      return true;
   end parse;
   

end ocpp.BootNotifications;

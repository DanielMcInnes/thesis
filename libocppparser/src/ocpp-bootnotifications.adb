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
     with Global => (In_Out => Ada.Text_IO.File_System),
     post => (if retval = true then index <= ocpp.packet.Length(msg))
   is
      temp : character;
   begin
      put("    findnonwhitespace 21: msg'size: "); put_line(msg'Size'Image);
      --put("18: msg'size: "); put_line(msg. );
      if ((index <= 0) or (index > ocpp.packet.Length(msg))) then
         retval := false;
         put("    findnonwhitespace 25: index: "); put_line("ERROR");
         return;
      end if;
           
      temp :=  ocpp.packet.Element(msg, index); put("    findnonwhitespace 27: index: "); put(index'Image); put(" temp: "); put_line(temp'image); 
      put("    findnonwhitespace 30: index: "); put_line(index'image);
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
      put("    findnonwhitespace 51: index: "); put_line(index'image);
      retval := true;
   end findnonwhitespace;

   procedure findnextinteger(msg: in ocpp.packet.Bounded_String;
                             index : in out Positive;
                             foundInteger: out integer;
                             found : out Boolean) 
     with  Global => (In_Out => Ada.Text_IO.File_System),
     post => (if found = true then index < Integer'Last)
   is
      temp : character;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      Put_Line("    97: findnextinteger: started");
      foundInteger := 0;
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         put("    20: index: "); put_line("ERROR");
         return;
      end if;
           
      findnonwhitespace(msg, index, found); Put_Line("    105: findnextinteger:");
      if (found = false) then
         return;
      end if;      
        
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         put("    110: "); put_line("ERROR");
         return;
      end if;
        
      temp :=  ocpp.packet.Element(msg, index);Put_Line("    116: findnextinteger:");
      ocpp.packet.Append(intstring, temp);
      if (ocpp.packet.Length(intstring) /= 1) then
         found := false;
         put("    118: "); put_line("ERROR");
         return;
      else
         Put("    123: findnextinteger:"); put_line(ocpp.packet.To_String(intstring));
         ocpp.single_char_to_int(intstring, foundInteger);Put_Line("    124: findnextinteger:");
         found := true;
         
      end if;
      Put_Line("    127: findnextinteger: finished");
      
   end findnextinteger;
   
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: out ocpp.packet.Bounded_String) 
     with  Global => (In_Out => Ada.Text_IO.File_System)
   is
      tempPositive : Integer;
      first : Integer;
      second : Integer;
      
   begin
      foundString := ocpp.packet.To_Bounded_String("");
      
      put("    117: index: "); put_line(index'image);
      findnonwhitespace(msg, index, found);
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
      foundString := ocpp.packet.Bounded_Slice(msg, first + 1, second -1); put("    146: tempstring: first: "); put(first'Image); put(" second: "); put(second'image); put(" foundString: "); put_line(ocpp.packet.To_String(foundString));
      found := true;
      index := second + 1;

   end findquotedstring;
   
   function validreason(thereason: ocpp.packet.Bounded_String) return Boolean 
     with  Global => null
   is
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
      index: Integer := 1;
      tempPositive: integer;
      
   begin
      bn.reason := ocpp.packet.To_Bounded_String("");
      bn.model := ocpp.packet.To_Bounded_String("");
      bn.vendor := ocpp.packet.To_Bounded_String(""); --put("161 index: "); put_line(index'image);
      bn.messageTypeId := 0;
      bn.messageId := ocpp.packet.To_Bounded_String("");
      bn.action := ocpp.packet.To_Bounded_String("");
      
      ocpp.move_index_past_token(msg, '[', index, tempPositive); if (tempPositive = 0) then return; end if;
      
      put("parse: 169 index: "); put_line(index'image);

      findnextinteger(msg, index, bn.messageTypeId, retval); if (retval = false) then return; end if;
      index := index + 1;
      put ("parse: messageTypeId: "); put_line(bn.messageTypeId'image); 

      put("parse: 171 index: "); put_line(index'image);
      if (retval = false) then return; end if;
      if (bn.messageTypeId /= 2) then return; end if;

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;

      put_line("parse: searching for messageId...");
      findquotedstring(msg, index, retval, bn.messageId);
      if (retval = false) then return; end if;      
      put("parse: messageId: "); Put_Line(ocpp.packet.To_String(bn.messageId));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, bn.action);
      if (retval = false) then return; end if;
      put("parse: action: "); Put_Line(ocpp.packet.To_String(bn.action));

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 233"); return; end if;
            
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 235"); return; end if;

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
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 253"); return; end if;
      
      put("parse: looking for reason ");
      findquotedstring(msg, index, retval, bn.reason);
      if (retval = false) then 
         return; 
      end if;
      
      put("parse: reason: "); Put_Line(ocpp.packet.To_String(bn.reason));
      if (validreason(bn.reason) = false) then return; end if;
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, bn.model);
      if (retval = false) then return; end if;
      put("parse: model: "); Put_Line(ocpp.packet.To_String(bn.model));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring(msg, index, retval, bn.vendor);
      if (retval = false) then return; end if;
      put("parse: vendor: "); Put_Line(ocpp.packet.To_String(bn.vendor)); 
      put_Line(ocpp.packet.To_String(bn.vendor) );
                                                                                
      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;

      ocpp.find_token(msg, ']', index, index, tempPositive); if ((tempPositive = 0) or (index > ocpp.packet.length(msg))) then put_line("ERROR: 227"); return; end if;
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

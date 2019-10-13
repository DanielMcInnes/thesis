pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Maps;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotification;

package body ocpp.BootNotification is
   procedure findnonwhitespace_packet is new findnonwhitespace(
                                                               string_t => ocpp.packet.Bounded_String, 
                                                               length => ocpp.packet.Length,
                                                               element => ocpp.packet.Element,
                                                               To_String => ocpp.packet.to_string
                                                              );

   procedure findnonwhitespace_messageid is new findnonwhitespace(
                                                                  string_t => ocpp.messageid_t.Bounded_String, 
                                                                  length => ocpp.messageid_t.Length,
                                                                  element => ocpp.messageid_t.Element,
                                                                  To_String => ocpp.messageid_t.to_string
                                                                 );
   
   procedure findquotedstring_messageid is new findquotedstring(
                                                                Max => ocpp.messageid_t.Max_Length, 
                                                                string_t => ocpp.messageid_t.Bounded_String, 
                                                                length => ocpp.messageid_t.Length,
                                                                To_String => ocpp.messageid_t.to_string,
                                                                To_Bounded_String =>  ocpp.messageid_t.To_Bounded_String
                                                               );

   procedure findquotedstring_action is new findquotedstring(
                                                             Max => ocpp.action_t.Max_Length, 
                                                             string_t => ocpp.action_t.Bounded_String, 
                                                             length => ocpp.action_t.Length,
                                                             To_String => ocpp.action_t.to_string,
                                                             To_Bounded_String =>  ocpp.action_t.To_Bounded_String
                                                            );

   procedure findquotedstring_packet is new findquotedstring(
                                                             Max => ocpp.packet.Max_Length, 
                                                             string_t => ocpp.packet.Bounded_String, 
                                                             length => ocpp.packet.Length,
                                                             To_String => ocpp.packet.to_string,
                                                             To_Bounded_String =>  ocpp.packet.To_Bounded_String
                                                            );

   procedure findquotedstring_reason is new findquotedstring(
                                                             Max => ocpp.BootNotification_t.request.reason.Max_Length, 
                                                             string_t => ocpp.BootNotification_t.request.Reason.Bounded_String,
                                                             length => ocpp.BootNotification_t.request.Reason.Length,
                                                             To_String => ocpp.BootNotification_t.request.Reason.to_string,
                                                             To_Bounded_String =>  ocpp.BootNotification_t.request.Reason.To_Bounded_String
                                                            );

   procedure findquotedstring_model is new findquotedstring(
                                                            Max => ocpp.bootnotification_t.request.model.Max_Length, 
                                                            string_t => ocpp.BootNotification_t.request.Model.Bounded_String,
                                                            length => ocpp.BootNotification_t.request.Model.Length,
                                                            To_String => ocpp.BootNotification_t.request.Model.to_string,
                                                            To_Bounded_String =>  ocpp.BootNotification_t.request.Model.To_Bounded_String
                                                           );

   procedure findquotedstring_vendor is new findquotedstring(
                                                             Max => ocpp.bootnotification_t.request.vendor.Max_Length, 
                                                             string_t => ocpp.BootNotification_t.request.Vendor.Bounded_String,
                                                             length => ocpp.BootNotification_t.request.Vendor.Length,
                                                             To_String => ocpp.BootNotification_t.request.Vendor.to_string,
                                                             To_Bounded_String =>  ocpp.BootNotification_t.request.Vendor.To_Bounded_String
                                                            );

   
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
           
      findnonwhitespace_packet(msg, index, found); Put_Line("    105: findnextinteger:");
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
   
   function validreason(thereason: ocpp.BootNotification_t.request.reason.Bounded_String) return Boolean 
     with  Global => null
   is
      bootreasons : constant BootReasons_t := (ocpp.BootNotification_t.request.reason.To_Bounded_String("ApplicationReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("FirmwareUpdate"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("LocalReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("PowerUp"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("RemoteReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("ScheduledReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("Triggered"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("Unknown"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("Watchdog"));
      --use all type ocpp.BootNotification.BootReasons_t;
   begin
      for I in bootreasons'Range loop
         --put(ocpp.packet.To_String(bootreasons(I)));
         if (ocpp.BootNotification_t.request.reason.To_String(bootreasons(I)) = ocpp.BootNotification_t.request.reason.To_String(thereason)) then 
            return true;
         end if;
      end loop;      
      return false;      
   end validreason;   
   
   procedure parse(msg:   in  ocpp.packet.Bounded_String;
                   request:    out ocpp.BootNotification.Request;
                   valid: out Boolean)
   is
      str : string := "reason";
      retval : boolean;
      dummybounded: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      index: Integer := 1;
      tempPositive: integer;
   begin
      valid:= false;
      
      request.reason := ocpp.BootNotification_t.request.reason.To_Bounded_String("");
      request.model := ocpp.BootNotification_t.request.Model.To_Bounded_String("");
      request.vendor := ocpp.BootNotification_t.request.Vendor.To_Bounded_String(""); --put("161 index: "); put_line(index'image);
      request.messageTypeId := 0;
      request.messageId := ocpp.messageid_t.To_Bounded_String("");
      request.action := ocpp.action_t.To_Bounded_String("");
      
      -- ocpp-bootnotification.adb:162:11: high: "Text_IO.File_System" is not initialized
      ocpp.move_index_past_token(msg, '[', index, tempPositive); if (tempPositive = 0) then return; end if;
      
      put("parse: 169 index: "); put_line(index'image);

      findnextinteger(msg, index, request.messageTypeId, retval); if (retval = false) then return; end if;
      index := index + 1;
      put ("parse: messageTypeId: "); put_line(request.messageTypeId'image); 

      put("parse: 171 index: "); put_line(index'image);
      if (retval = false) then return; end if;
      if (request.messageTypeId /= 2) then return; end if;

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;

      put_line("parse: searching for messageId..."); 
      findquotedstring_messageid(msg, index, retval, request.messageId);
      if (retval = false) then return; end if;      
      put("parse: messageId: "); Put_Line(ocpp.messageid_t.To_String(request.messageId));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_action(msg, index, retval, request.action);
      if (retval = false) then return; end if;
      put("parse: action: "); Put_Line(ocpp.action_t.To_String(request.action));

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 233"); return; end if;
            
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 235"); return; end if;

      put("parse: looking for 'reason': ");
      findquotedstring_packet(msg, index, retval, dummybounded);
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
      findquotedstring_reason(msg, index, retval, request.reason);
      if (retval = false) then 
         return; 
      end if;
      
      put("parse: reason: "); Put_Line(ocpp.BootNotification_t.request.reason.To_String(request.reason));
      if (validreason(request.reason) = false) then return; end if;
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_model(msg, index, retval, request.model);
      if (retval = false) then return; end if;
      put("parse: model: "); Put_Line(ocpp.BootNotification_t.request.Model.To_String(request.model));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then put_line("ERROR: 227"); return; end if;
      
      findquotedstring_vendor(msg, index, retval, request.vendor);
      if (retval = false) then return; end if;
      put("parse: vendor: "); Put_Line(ocpp.BootNotification_t.request.Vendor.To_String(request.vendor)); 
                                                                                      
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
      
      valid := true;
      Put_Line("parse: hooray!"); 
      Put(ocpp.BootNotification_t.request.Vendor.Length(request.vendor)'Image);
   end parse;
   
end ocpp.BootNotification;

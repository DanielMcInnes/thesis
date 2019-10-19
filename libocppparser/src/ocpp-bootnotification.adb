pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Maps;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with ocpp; 
with ocpp.BootNotification;
with utils;

package body ocpp.BootNotification is

   procedure packetContainsString is new utils.contains(
                                               string_haystack => ocpp.packet.Bounded_String, 
                                                        haystack_to_string => ocpp.packet.To_String,
                                                        haystack_length => ocpp.packet.Length
                                                        );

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
     with  Global => null,
     post => (if found = true then index < Integer'Last)
   is
      temp : character;
      intstring : ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   begin
      foundInteger := 0;
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         ocpp.put("    20: index: "); ocpp.put_line("ERROR");
         return;
      end if;
           
      findnonwhitespace_packet(msg, index, found); --Ocpp.Put_Line("    105: findnextinteger:");
      if (found = false) then
         return;
      end if;      
        
      if (index > ocpp.packet.Length(msg)) then
         found := false;
         ocpp.put("    110: "); ocpp.put_line("ERROR");
         return;
      end if;
        
      temp :=  ocpp.packet.Element(msg, index);--Ocpp.Put_Line("    116: findnextinteger:");
      ocpp.packet.Append(intstring, temp);
      if (ocpp.packet.Length(intstring) /= 1) then
         found := false;
         ocpp.put("    118: "); ocpp.put_line("ERROR");
         return;
      else
         --Ocpp.Put("    123: findnextinteger:"); ocpp.put_line(ocpp.packet.To_String(intstring));
         ocpp.single_char_to_int(intstring, foundInteger); --Ocpp.Put_Line("    124: findnextinteger:");
         found := true;
         
      end if;
      --Ocpp.Put_Line("    127: findnextinteger: finished");
      
   end findnextinteger;
   
   procedure validreason(thereason: in ocpp.BootNotification_t.request.reason.Bounded_String;
                        valid: out Boolean)
   is
   begin      
      for I in validreasons'Range loop
         if (ocpp.BootNotification_t.request.reason.To_String(validreasons(I)) = ocpp.BootNotification_t.request.reason.To_String(thereason)) then 
            valid := true;
            return;
         end if;
      end loop;      
      valid := false;      
   end validreason;   
   
   procedure parse(msg:   in  ocpp.packet.Bounded_String;
                   request: out ocpp.BootNotification.Request;
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
      request.vendor := ocpp.BootNotification_t.request.Vendor.To_Bounded_String(""); --ocpp.put("161 index: "); ocpp.put_line(index'image);
      request.messageTypeId := 0;
      request.messageId := ocpp.messageid_t.To_Bounded_String("");
      request.action := ocpp.action_t.To_Bounded_String("");
      
      packetContainsString(msg, strBootNotification, retval);
      
      if retval = false then
         return;
      end if;
      
      ocpp.move_index_past_token(msg, '[', index, tempPositive); if (tempPositive = 0) then return; end if;
      
      --ocpp.put("parse: 169 index: "); ocpp.put_line(index'image);

      findnextinteger(msg, index, request.messageTypeId, retval); if (retval = false) then return; end if;
      index := index + 1;
      --ocpp.put ("parse: messageTypeId: "); ocpp.put_line(request.messageTypeId'image); 
      
      --ocpp.put("parse: 171 index: "); ocpp.put_line(index'image);
      if (retval = false) then return; end if;
      if (request.messageTypeId /= 2) then return; end if;

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;

      --ocpp.put_line("parse: searching for messageId..."); 
      findquotedstring_messageid(msg, index, retval, request.messageId);
      if (ocpp.messageid_t.Length(request.messageid) = 0) then return; end if;
      if (retval = false) then return; end if;      
      --ocpp.put("parse: messageId: "); Ocpp.Put_Line(ocpp.messageid_t.To_String(request.messageId));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_action(msg, index, retval, request.action);
      if (retval = false) then return; end if;
      if (ocpp.action_t.To_String(request.action) /= ("BootNotification")) then return; end if;
      
      --ocpp.put("parse: action: "); Ocpp.Put_Line(ocpp.action_t.To_String(request.action));

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 233"); return; end if;
            
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 235"); return; end if;

      --ocpp.put("parse: looking for 'reason': ");
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then 
         ocpp.put("parse: ERROR: looking for 'reason': ");
         return; 
      end if;
      
      --ocpp.put("parse: found: "); Ocpp.Put_Line(ocpp.packet.To_String(dummybounded));
      if (ocpp.packet.To_String(dummybounded) /= str) then 
         --ocpp.put("parse: 243: ERROR: looking for 'reason': ");
         --ocpp.put("comparing with: "); ocpp.put_line(str);
         return; 
      end if;

      --ocpp.put("parse: 244: looking for ':' ");
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 253"); return; end if;
      
      --ocpp.put("parse: looking for reason ");
      findquotedstring_reason(msg, index, retval, request.reason);
      if (retval = false) then 
         return; 
      end if;
      
      --ocpp.put("parse: reason: "); Ocpp.Put_Line(ocpp.BootNotification_t.request.reason.To_String(request.reason));
      validreason(request.reason, retval); 
      if (retval = false) then return; end if;
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "chargingStation") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "model") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_model(msg, index, retval, request.model);
      if (retval = false) then return; end if;
      --ocpp.put("parse: model: "); Ocpp.Put_Line(ocpp.BootNotification_t.request.Model.To_String(request.model));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (ocpp.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_vendor(msg, index, retval, request.vendor);
      if (retval = false) then return; end if;
      --ocpp.put("parse: vendor: "); Ocpp.Put_Line(ocpp.BootNotification_t.request.Vendor.To_String(request.vendor)); 
                                                                                      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then ocpp.put_line("ERROR: 227"); return; end if;

      ocpp.find_token(msg, ']', index, index, tempPositive); if ((tempPositive = 0) or (index > ocpp.packet.length(msg))) then ocpp.put_line("ERROR: 227"); return; end if;
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
      Ocpp.Put_Line("parse: Received valid BootNoticationRequest packet"); 
   end parse;
   
end ocpp.BootNotification;

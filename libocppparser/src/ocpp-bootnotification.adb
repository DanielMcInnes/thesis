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
                                               string_haystack => NonSparkTypes.packet.Bounded_String, 
                                                        haystack_to_string => NonSparkTypes.packet.To_String,
                                                        haystack_length => NonSparkTypes.packet.Length
                                                        );

   procedure findnonwhitespace_packet is new findnonwhitespace(
                                                               string_t => NonSparkTypes.packet.Bounded_String, 
                                                               length => NonSparkTypes.packet.Length,
                                                               element => NonSparkTypes.packet.Element,
                                                               To_String => NonSparkTypes.packet.to_string
                                                              );

   procedure findnonwhitespace_messageid is new findnonwhitespace(
                                                                  string_t => NonSparkTypes.messageid_t.Bounded_String, 
                                                                  length => NonSparkTypes.messageid_t.Length,
                                                                  element => NonSparkTypes.messageid_t.Element,
                                                                  To_String => NonSparkTypes.messageid_t.to_string
                                                                 );
   
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

   procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure findquotedstring_reason is new findquotedstring(
                                                             Max => NonSparkTypes.BootReasonEnumType.Max_Length, 
                                                             string_t => NonSparkTypes.BootReasonEnumType.Bounded_String,
                                                             length => NonSparkTypes.BootReasonEnumType.Length,
                                                             To_String => NonSparkTypes.BootReasonEnumType.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.BootReasonEnumType.To_Bounded_String
                                                            );

   procedure findquotedstring_model is new findquotedstring(
                                                            Max => NonSparkTypes.ChargingStationType.model.Max_Length, 
                                                            string_t => NonSparkTypes.ChargingStationType.Model.Bounded_String,
                                                            length => NonSparkTypes.ChargingStationType.Model.Length,
                                                            To_String => NonSparkTypes.ChargingStationType.Model.to_string,
                                                            To_Bounded_String =>  NonSparkTypes.ChargingStationType.Model.To_Bounded_String
                                                           );

   procedure findquotedstring_vendor is new findquotedstring(
                                                             Max => NonSparkTypes.ChargingStationType.vendorName.Max_Length, 
                                                             string_t => NonSparkTypes.ChargingStationType.vendorName.Bounded_String,
                                                             length => NonSparkTypes.ChargingStationType.vendorName.Length,
                                                             To_String => NonSparkTypes.ChargingStationType.vendorName.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.ChargingStationType.vendorName.To_Bounded_String
                                                            );

   
   procedure findnextinteger(msg: in NonSparkTypes.packet.Bounded_String;
                             index : in out Positive;
                             foundInteger: out integer;
                             found : out Boolean) 
     with  Global => null,
     post => (if found = true then index < Integer'Last)
   is
      temp : character;
      intstring : NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
   begin
      foundInteger := 0;
      if (index > NonSparkTypes.packet.Length(msg)) then
         found := false;
         NonSparkTypes.put("    20: index: "); NonSparkTypes.put_line("ERROR");
         return;
      end if;
           
      findnonwhitespace_packet(msg, index, found); NonSparkTypes.put_Line("    105: findnextinteger:");
      if (found = false) then
         return;
      end if;      
        
      if (index > NonSparkTypes.packet.Length(msg)) then
         found := false;
         NonSparkTypes.put("    110: "); NonSparkTypes.put_line("ERROR");
         return;
      end if;
        
      temp :=  NonSparkTypes.packet.Element(msg, index);NonSparkTypes.put_Line("    116: findnextinteger:");
      NonSparkTypes.packet.Append(intstring, temp);
      if (NonSparkTypes.packet.Length(intstring) /= 1) then
         found := false;
         NonSparkTypes.put("    118: "); NonSparkTypes.put_line("ERROR");
         return;
      else
         NonSparkTypes.put("    123: findnextinteger:"); NonSparkTypes.put_line(NonSparkTypes.packet.To_String(intstring));
         NonSparkTypes.single_char_to_int(intstring, foundInteger); NonSparkTypes.put_Line("    124: findnextinteger:");
         found := true;
         
      end if;
      NonSparkTypes.put_Line("    127: findnextinteger: finished");
      
   end findnextinteger;
   
   procedure validreason(thereason: in NonSparkTypes.BootReasonEnumType.Bounded_String;
                        valid: out Boolean)
   is
   begin      
      for I in validreasons'Range loop
         if (NonSparkTypes.BootReasonEnumType.To_String(validreasons(I)) = NonSparkTypes.BootReasonEnumType.To_String(thereason)) then 
            valid := true;
            return;
         end if;
      end loop;      
      valid := false;      
   end validreason;   
   
   procedure DefaultInitialize(Self : out ocpp.BootNotification.Request) is
   begin
      self.messagetypeid := 0;
      self.messageid := messageid_t.To_Bounded_String("");
      self.action := action_t.To_Bounded_String("");
      self.reason:= NonSparkTypes.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
      ocpp.Initialize(self.chargingStation);
   end DefaultInitialize;

   
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   request: out ocpp.BootNotification.Request;
                   valid: out Boolean)
   is
      str : string := "reason";
      retval : boolean;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      index: Integer := 1;
      tempPositive: integer;
   begin
      valid:= false;
      DefaultInitialize(request);
      packetContainsString(msg, strBootNotification, retval);
      
      if retval = false then
         return;
      end if;
      
      ocpp.move_index_past_token(msg, '[', index, tempPositive); if (tempPositive = 0) then return; end if;
      
      NonSparkTypes.put("parse: 169 index: "); NonSparkTypes.put_line(index'image);

      findnextinteger(msg, index, request.messageTypeId, retval); if (retval = false) then return; end if;
      index := index + 1;
      NonSparkTypes.put ("parse: messageTypeId: "); NonSparkTypes.put_line(request.messageTypeId'image); 
      
      NonSparkTypes.put("parse: 171 index: "); NonSparkTypes.put_line(index'image);
      if (retval = false) then return; end if;
      if (request.messageTypeId /= 2) then return; end if;

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;

      NonSparkTypes.put_line("parse: searching for messageId..."); 
      findquotedstring_messageid(msg, index, retval, request.messageId);
      if (NonSparkTypes.messageid_t.Length(request.messageid) = 0) then return; end if;
      if (retval = false) then return; end if;      
      NonSparkTypes.put("parse: messageId: "); NonSparkTypes.put_Line(NonSparkTypes.messageid_t.To_String(request.messageId));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_action(msg, index, retval, request.action);
      if (retval = false) then return; end if;
      if (NonSparkTypes.action_t.To_String(request.action) /= strBootNotification) then return; end if;
      
      NonSparkTypes.put("parse: action: "); NonSparkTypes.put_Line(NonSparkTypes.action_t.To_String(request.action));

      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 233"); return; end if;
            
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 235"); return; end if;

      NonSparkTypes.put("parse: looking for 'reason': ");
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then 
         NonSparkTypes.put("parse: ERROR: looking for 'reason': ");
         return; 
      end if;
      
      NonSparkTypes.put("parse: found: "); NonSparkTypes.put_Line(NonSparkTypes.packet.To_String(dummybounded));
      if (NonSparkTypes.packet.To_String(dummybounded) /= str) then 
         NonSparkTypes.put("parse: 243: ERROR: looking for 'reason': ");
         NonSparkTypes.put("comparing with: "); NonSparkTypes.put_line(str);
         return; 
      end if;

      NonSparkTypes.put("parse: 244: looking for ':' ");
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 253"); return; end if;
      
      NonSparkTypes.put("parse: looking for reason ");
      findquotedstring_reason(msg, index, retval, request.reason);
      if (retval = false) then 
         return; 
      end if;
      
      NonSparkTypes.put("parse: reason: "); NonSparkTypes.put_Line(NonSparkTypes.BootReasonEnumType.To_String(request.reason));
      validreason(request.reason, retval); 
      if (retval = false) then return; end if;
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (NonSparkTypes.packet.To_String(dummybounded) /= "chargingStation") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '{', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (NonSparkTypes.packet.To_String(dummybounded) /= "model") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_model(msg, index, retval, request.chargingStation.model);
      if (retval = false) then return; end if;
      --NonSparkTypes.put("parse: model: "); NonSparkTypes.put_Line(NonSparkTypes.bootnotification_t.request.Model.To_String(request.model));
      
      ocpp.move_index_past_token(msg, ',', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_packet(msg, index, retval, dummybounded);
      if (retval = false) then return; end if;
      if (NonSparkTypes.packet.To_String(dummybounded) /= "vendorName") then return; end if;
      
      ocpp.move_index_past_token(msg, ':', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      findquotedstring_vendor(msg, index, retval, request.chargingStation.vendorName);
      if (retval = false) then return; end if;
      --NonSparkTypes.put("parse: vendor: "); NonSparkTypes.put_Line(NonSparkTypes.bootnotification_t.request.Vendor.To_String(request.vendor)); 
                                                                                      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
      
      ocpp.move_index_past_token(msg, '}', index, tempPositive); if (tempPositive = 0) then NonSparkTypes.put_line("ERROR: 227"); return; end if;

      ocpp.find_token(msg, ']', index, index, tempPositive); if ((tempPositive = 0) or (index > NonSparkTypes.packet.length(msg))) then NonSparkTypes.put_line("ERROR: 227"); return; end if;
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
      NonSparkTypes.put_Line("parse: Received valid BootNoticationRequest packet"); 
   end parse;
   
end ocpp.BootNotification;

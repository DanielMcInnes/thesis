pragma SPARK_mode (on); 

with ocpp;
with ocpp.BootNotificationResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.BootNotificationResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.BootNotificationResponse.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.currentTime := BootNotificationResponseStrings.strcurrentTime_t.To_Bounded_String("");
      self.interval := -1;
      self.status := RegistrationStatusEnumType.Accepted;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.BootNotificationResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid BootNotificationResponsestatus messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid BootNotificationResponsestatus messageid"); return; end if;

      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid BootNotificationResponsestatus"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "currentTime", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid BootNotificationResponsecurrentTime"); return; end if;

      self.currentTime := BootNotificationResponseStrings.strcurrentTime_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "interval", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid BootNotificationResponseinterval"); return; end if;
      self.interval := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "status", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid BootNotificationResponsestatus"); return; end if;

      ocpp.RegistrationStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.status, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid BootNotificationResponsestatus"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid BootNotificationResponsestatus"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strstatus : RegistrationStatusEnumType.string_t.Bounded_String;
   begin
      RegistrationStatusEnumType.ToString(Self.status, strstatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "currentTime" & '"' & ": " & '"' & BootNotificationResponseStrings.strcurrentTime_t.To_String(Self.currentTime) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "interval" & '"' & ": " & Self.interval'Image & "," & ASCII.LF
                                                      & "       " & '"' & "status" & '"' & ":"  & '"' & RegistrationStatusEnumType.string_t.To_String(strstatus) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.BootNotificationResponse;

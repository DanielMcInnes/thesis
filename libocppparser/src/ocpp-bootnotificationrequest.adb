pragma SPARK_mode (on); 

with ocpp;
with ocpp.BootNotificationRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.BootNotificationRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.BootNotificationRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      ChargingStationType.Initialize(self.chargingStation);
      self.reason := ApplicationReset;

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.BootNotificationRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid BootNotificationRequestreason messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid BootNotificationRequestreason messageid"); return; end if;

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid BootNotificationRequestreason"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "chargingStation");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid BootNotificationRequestchargingStation"); return; end if;

      ChargingStationType.parse(msg, msgindex, self.chargingStation, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid BootNotificationRequestchargingStation"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "reason", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid BootNotificationRequestreason"); return; end if;

      ocpp.BootReasonEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.reason, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid BootNotificationRequestreason"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid BootNotificationRequestreason"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strchargingStation : NonSparkTypes.packet.Bounded_String;
      strreason : BootReasonEnumType.string_t.Bounded_String;
   begin
      ChargingStationType.To_Bounded_String(Self.chargingStation, strchargingStation);
      BootReasonEnumType.ToString(Self.reason, strreason);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "chargingStation" & '"' & ":" & NonSparkTypes.packet.To_String(strchargingStation) & "," & ASCII.LF
                                                      & "       " & '"' & "reason" & '"' & ":"  & '"' & BootReasonEnumType.string_t.To_String(strreason) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.BootNotificationRequest;

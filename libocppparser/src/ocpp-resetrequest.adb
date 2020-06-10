pragma SPARK_mode (on); 

with ocpp;
with ocpp.ResetRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.ResetRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.ResetRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      self.zzztype := ResetEnumType.Immediate;
      self.evseId := -1;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.ResetRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid ResetRequestevseId messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid ResetRequestevseId messageid"); return; end if;

      ocpp.ParseAction(msg, msgindex, self.action, valid);
      if (valid = false) then NonSparkTypes.put_line("404 Invalid action"); return; end if; 

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid ResetRequestevseId"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "type", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ResetRequesttype"); return; end if;

      ocpp.ResetEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.zzztype, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid ResetRequesttype"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "evseId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid ResetRequestevseId"); return; end if;
      self.evseId := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid ResetRequestevseId"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strtype : ResetEnumType.string_t.Bounded_String;
   begin
      ResetEnumType.ToString(Self.zzztype, strtype);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "type" & '"' & ":"  & '"' & ResetEnumType.string_t.To_String(strtype) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "evseId" & '"' & ": " & Self.evseId'Image & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.ResetRequest;

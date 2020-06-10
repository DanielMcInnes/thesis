pragma SPARK_mode (on); 

with ocpp;
with ocpp.ResetResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.ResetResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.ResetResponse.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.status := ResetStatusEnumType.Accepted;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.ResetResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid ResetResponsestatus messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid ResetResponsestatus messageid"); return; end if;

      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid ResetResponsestatus"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "status", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ResetResponsestatus"); return; end if;

      ocpp.ResetStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.status, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid ResetResponsestatus"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid ResetResponsestatus"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strstatus : ResetStatusEnumType.string_t.Bounded_String;
   begin
      ResetStatusEnumType.ToString(Self.status, strstatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "status" & '"' & ":"  & '"' & ResetStatusEnumType.string_t.To_String(strstatus) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.ResetResponse;

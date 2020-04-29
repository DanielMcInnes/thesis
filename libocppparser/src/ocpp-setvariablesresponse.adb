pragma SPARK_mode (on); 

with ocpp;
with ocpp.SetVariablesResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.SetVariablesResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.SetVariablesResponse.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      setVariableResultTypeArray.Initialize(self.setVariableResult);

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.SetVariablesResponse.T;
                   valid: out Boolean
                  )
   is
      strsetVariableResult: NonSparkTypes.packet.Bounded_String;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid SetVariablesResponsesetVariableResult"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "setVariableResult");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid SetVariablesResponsesetVariableResult"); return; end if;

      SetVariableResultTypeArray.FromString(msg, msgindex, self.setVariableResult, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid SetVariablesResponsesetVariableResult"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid SetVariablesResponsesetVariableResult"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strsetVariableResult: NonSparkTypes.packet.Bounded_String;
   begin
      SetVariableResultTypeArray.To_Bounded_String(strsetVariableResult, self.setVariableResult);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "setVariableResult" & '"' & ": " & NonSparkTypes.packet.To_String(strsetVariableResult) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.SetVariablesResponse;

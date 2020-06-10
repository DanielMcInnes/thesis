pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetVariablesResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariablesResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.GetVariablesResponse.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      getVariableResultTypeArray.Initialize(self.getVariableResult);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.GetVariablesResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid GetVariablesResponsegetVariableResult messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid GetVariablesResponsegetVariableResult messageid"); return; end if;

      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid GetVariablesResponsegetVariableResult"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "getVariableResult");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid GetVariablesResponsegetVariableResult"); return; end if;

      getVariableResultTypeArray.FromString(msg, msgindex, self.getVariableResult, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid GetVariablesResponsegetVariableResult"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GetVariablesResponsegetVariableResult"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strgetVariableResult: NonSparkTypes.packet.Bounded_String;
   begin
      getVariableResultTypeArray.To_Bounded_String(strgetVariableResult, self.getVariableResult);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "getVariableResult" & '"' & ": " & NonSparkTypes.packet.To_String(strgetVariableResult) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetVariablesResponse;

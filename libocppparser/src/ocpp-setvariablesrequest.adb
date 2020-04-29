pragma SPARK_mode (on); 

with ocpp;
with ocpp.SetVariablesRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.SetVariablesRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.SetVariablesRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      setVariableDataTypeArray.Initialize(self.setVariableData);

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.SetVariablesRequest.T;
                   valid: out Boolean
                  )
   is
      strsetVariableData: NonSparkTypes.packet.Bounded_String;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid SetVariablesRequestsetVariableData messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid SetVariablesRequestsetVariableData messageid"); return; end if;

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid SetVariablesRequestsetVariableData"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "setVariableData");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid SetVariablesRequestsetVariableData"); return; end if;

      SetVariableDataTypeArray.FromString(msg, msgindex, self.setVariableData, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid SetVariablesRequestsetVariableData"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid SetVariablesRequestsetVariableData"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strsetVariableData: NonSparkTypes.packet.Bounded_String;
   begin
      SetVariableDataTypeArray.To_Bounded_String(strsetVariableData, self.setVariableData);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "setVariableData" & '"' & ": " & NonSparkTypes.packet.To_String(strsetVariableData) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.SetVariablesRequest;

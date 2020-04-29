pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetVariablesRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariablesRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.GetVariablesRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      getVariableDataTypeArray.Initialize(self.getVariableData);

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.GetVariablesRequest.T;
                   valid: out Boolean
                  )
   is
      strgetVariableData: NonSparkTypes.packet.Bounded_String;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid GetVariablesRequestgetVariableData messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid GetVariablesRequestgetVariableData messageid"); return; end if;

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid GetVariablesRequestgetVariableData"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "getVariableData");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid GetVariablesRequestgetVariableData"); return; end if;

      GetVariableDataTypeArray.FromString(msg, msgindex, self.getVariableData, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid GetVariablesRequestgetVariableData"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GetVariablesRequestgetVariableData"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strgetVariableData: NonSparkTypes.packet.Bounded_String;
   begin
      GetVariableDataTypeArray.To_Bounded_String(strgetVariableData, self.getVariableData);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "getVariableData" & '"' & ": " & NonSparkTypes.packet.To_String(strgetVariableData) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetVariablesRequest;

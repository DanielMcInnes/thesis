pragma SPARK_mode (on); 

with ocpp;
with ocpp.TransactionEventRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.TransactionEventRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.TransactionEventRequest.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      self.eventType := TransactionEventEnumType.Ended;
      meterValueTypeArray.Initialize(self.meterValue);
      self.timestamp := TransactionEventRequestStrings.strtimestamp_t.To_Bounded_String("");
      self.triggerReason := TriggerReasonEnumType.Authorized;
      self.seqNo := -1;
      self.offline := False;
      self.numberOfPhasesUsed := -1;
      self.cableMaxCurrent := -1;
      self.reservationId := -1;
      TransactionType.Initialize(self.transactionInfo);
      EVSEType.Initialize(self.evse);
      IdTokenType.Initialize(self.idToken);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.TransactionEventRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid TransactionEventRequestidToken messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid TransactionEventRequestidToken messageid"); return; end if;

      ocpp.ParseAction(msg, msgindex, self.action, valid);
      if (valid = false) then NonSparkTypes.put_line("404 Invalid action"); return; end if; 

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid TransactionEventRequestidToken"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "eventType", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionEventRequesteventType"); return; end if;

      ocpp.TransactionEventEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.eventType, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid TransactionEventRequesteventType"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "meterValue");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid TransactionEventRequestmeterValue"); return; end if;

      meterValueTypeArray.FromString(msg, msgindex, self.meterValue, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid TransactionEventRequestmeterValue"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "timestamp", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionEventRequesttimestamp"); return; end if;

      self.timestamp := TransactionEventRequestStrings.strtimestamp_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "triggerReason", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionEventRequesttriggerReason"); return; end if;

      ocpp.TriggerReasonEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.triggerReason, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid TransactionEventRequesttriggerReason"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "seqNo", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionEventRequestseqNo"); return; end if;
      self.seqNo := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "offline", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionEventRequestoffline"); return; end if;
      self.offline := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "numberOfPhasesUsed", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionEventRequestnumberOfPhasesUsed"); return; end if;
      self.numberOfPhasesUsed := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "cableMaxCurrent", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionEventRequestcableMaxCurrent"); return; end if;
      self.cableMaxCurrent := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "reservationId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionEventRequestreservationId"); return; end if;
      self.reservationId := dummyInt;

      ocpp.findQuotedKey(msg, msgIndex, valid, "transactionInfo");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid TransactionEventRequesttransactionInfo"); return; end if;

      TransactionType.parse(msg, msgindex, self.transactionInfo, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid TransactionEventRequesttransactionInfo"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "evse");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid TransactionEventRequestevse"); return; end if;

      EVSEType.parse(msg, msgindex, self.evse, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid TransactionEventRequestevse"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "idToken");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid TransactionEventRequestidToken"); return; end if;

      IdTokenType.parse(msg, msgindex, self.idToken, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid TransactionEventRequestidToken"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid TransactionEventRequestidToken"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      streventType : TransactionEventEnumType.string_t.Bounded_String;
      strmeterValue: NonSparkTypes.packet.Bounded_String;
      strtriggerReason : TriggerReasonEnumType.string_t.Bounded_String;
      strtransactionInfo : NonSparkTypes.packet.Bounded_String;
      strevse : NonSparkTypes.packet.Bounded_String;
      stridToken : NonSparkTypes.packet.Bounded_String;
   begin
      TransactionEventEnumType.ToString(Self.eventType, streventType);
      meterValueTypeArray.To_Bounded_String(strmeterValue, self.meterValue);
      TriggerReasonEnumType.ToString(Self.triggerReason, strtriggerReason);
      TransactionType.To_Bounded_String(Self.transactionInfo, strtransactionInfo);
      EVSEType.To_Bounded_String(Self.evse, strevse);
      IdTokenType.To_Bounded_String(Self.idToken, stridToken);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "eventType" & '"' & ":"  & '"' & TransactionEventEnumType.string_t.To_String(streventType) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "meterValue" & '"' & ": " & NonSparkTypes.packet.To_String(strmeterValue) & "," & ASCII.LF
                                                      & "    " & '"' & "timestamp" & '"' & ": " & '"' & TransactionEventRequestStrings.strtimestamp_t.To_String(Self.timestamp) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "triggerReason" & '"' & ":"  & '"' & TriggerReasonEnumType.string_t.To_String(strtriggerReason) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "seqNo" & '"' & ": " & Self.seqNo'Image & "," & ASCII.LF
                                                      & "    " & '"' & "offline" & '"' & ": " & Self.offline'Image & "," & ASCII.LF
                                                      & "    " & '"' & "numberOfPhasesUsed" & '"' & ": " & Self.numberOfPhasesUsed'Image & "," & ASCII.LF
                                                      & "    " & '"' & "cableMaxCurrent" & '"' & ": " & Self.cableMaxCurrent'Image & "," & ASCII.LF
                                                      & "    " & '"' & "reservationId" & '"' & ": " & Self.reservationId'Image & "," & ASCII.LF
                                                      & "    " & '"' & "transactionInfo" & '"' & ":" & NonSparkTypes.packet.To_String(strtransactionInfo) & "," & ASCII.LF
                                                      & "    " & '"' & "evse" & '"' & ":" & NonSparkTypes.packet.To_String(strevse) & "," & ASCII.LF
                                                      & "    " & '"' & "idToken" & '"' & ":" & NonSparkTypes.packet.To_String(stridToken) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.TransactionEventRequest;

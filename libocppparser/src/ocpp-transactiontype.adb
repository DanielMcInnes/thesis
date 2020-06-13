pragma SPARK_mode (on); 

with ocpp;
with ocpp.TransactionType;
with Ada.Strings; use Ada.Strings;

package body ocpp.TransactionType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.TransactionType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.transactionId := TransactionTypeStrings.strtransactionId_t.To_Bounded_String("");
      self.chargingState := ChargingStateEnumType.Charging;
      self.timeSpentCharging := -1;
      self.stoppedReason := ReasonEnumType.DeAuthorized;
      self.remoteStartId := -1;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.TransactionType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "transactionId", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionTypetransactionId"); return; end if;

      self.transactionId := TransactionTypeStrings.strtransactionId_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "chargingState", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionTypechargingState"); return; end if;

      ocpp.ChargingStateEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.chargingState, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid TransactionTypechargingState"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "timeSpentCharging", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionTypetimeSpentCharging"); return; end if;
      self.timeSpentCharging := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "stoppedReason", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid TransactionTypestoppedReason"); return; end if;

      ocpp.ReasonEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.stoppedReason, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid TransactionTypestoppedReason"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "remoteStartId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid TransactionTyperemoteStartId"); return; end if;
      self.remoteStartId := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid TransactionTyperemoteStartId"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strchargingState : ChargingStateEnumType.string_t.Bounded_String;
      strstoppedReason : ReasonEnumType.string_t.Bounded_String;
   begin
      ChargingStateEnumType.ToString(Self.chargingState, strchargingState);
      ReasonEnumType.ToString(Self.stoppedReason, strstoppedReason);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "transactionId" & '"' & ": " & '"' & TransactionTypeStrings.strtransactionId_t.To_String(Self.transactionId) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "chargingState" & '"' & ":"  & '"' & ChargingStateEnumType.string_t.To_String(strchargingState) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "timeSpentCharging" & '"' & ": " & Self.timeSpentCharging'Image & "," & ASCII.LF
                                                      & "       " & '"' & "stoppedReason" & '"' & ":"  & '"' & ReasonEnumType.string_t.To_String(strstoppedReason) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "remoteStartId" & '"' & ": " & Self.remoteStartId'Image & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.TransactionType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.IdTokenInfoType;
with Ada.Strings; use Ada.Strings;

package body ocpp.IdTokenInfoType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.IdTokenInfoType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.status := AuthorizationStatusEnumType.Accepted;
      self.cacheExpiryDateTime := IdTokenInfoTypeStrings.strcacheExpiryDateTime_t.To_Bounded_String("");
      self.chargingPriority := -1;
      self.language1 := IdTokenInfoTypeStrings.strlanguage1_t.To_Bounded_String("");
      evseIdTypeArray.Initialize(self.evseId);
      GroupIdTokenType.Initialize(self.groupIdToken);
      self.language2 := IdTokenInfoTypeStrings.strlanguage2_t.To_Bounded_String("");
      MessageContentType.Initialize(self.personalMessage);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.IdTokenInfoType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "status", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenInfoTypestatus"); return; end if;

      ocpp.AuthorizationStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.status, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid IdTokenInfoTypestatus"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "cacheExpiryDateTime", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenInfoTypecacheExpiryDateTime"); return; end if;

      self.cacheExpiryDateTime := IdTokenInfoTypeStrings.strcacheExpiryDateTime_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "chargingPriority", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid IdTokenInfoTypechargingPriority"); return; end if;
      self.chargingPriority := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "language1", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenInfoTypelanguage1"); return; end if;

      self.language1 := IdTokenInfoTypeStrings.strlanguage1_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKey(msg, msgIndex, valid, "evseId");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid IdTokenInfoTypeevseId"); return; end if;

      evseIdTypeArray.FromString(msg, msgindex, self.evseId, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid IdTokenInfoTypeevseId"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "groupIdToken");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid IdTokenInfoTypegroupIdToken"); return; end if;

      GroupIdTokenType.parse(msg, msgindex, self.groupIdToken, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid IdTokenInfoTypegroupIdToken"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "language2", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenInfoTypelanguage2"); return; end if;

      self.language2 := IdTokenInfoTypeStrings.strlanguage2_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKey(msg, msgIndex, valid, "personalMessage");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid IdTokenInfoTypepersonalMessage"); return; end if;

      MessageContentType.parse(msg, msgindex, self.personalMessage, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid IdTokenInfoTypepersonalMessage"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid IdTokenInfoTypepersonalMessage"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strstatus : AuthorizationStatusEnumType.string_t.Bounded_String;
      strevseId: NonSparkTypes.packet.Bounded_String;
      strgroupIdToken : NonSparkTypes.packet.Bounded_String;
      strpersonalMessage : NonSparkTypes.packet.Bounded_String;
   begin
      AuthorizationStatusEnumType.ToString(Self.status, strstatus);
      evseIdTypeArray.To_Bounded_String(strevseId, self.evseId);
      GroupIdTokenType.To_Bounded_String(Self.groupIdToken, strgroupIdToken);
      MessageContentType.To_Bounded_String(Self.personalMessage, strpersonalMessage);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "status" & '"' & ":"  & '"' & AuthorizationStatusEnumType.string_t.To_String(strstatus) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "cacheExpiryDateTime" & '"' & ": " & '"' & IdTokenInfoTypeStrings.strcacheExpiryDateTime_t.To_String(Self.cacheExpiryDateTime) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "chargingPriority" & '"' & ": " & Self.chargingPriority'Image & "," & ASCII.LF
                                                      & "    " & '"' & "language1" & '"' & ": " & '"' & IdTokenInfoTypeStrings.strlanguage1_t.To_String(Self.language1) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "evseId" & '"' & ": " & NonSparkTypes.packet.To_String(strevseId) & "," & ASCII.LF
                                                      & "    " & '"' & "groupIdToken" & '"' & ":" & NonSparkTypes.packet.To_String(strgroupIdToken) & "," & ASCII.LF
                                                      & "    " & '"' & "language2" & '"' & ": " & '"' & IdTokenInfoTypeStrings.strlanguage2_t.To_String(Self.language2) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "personalMessage" & '"' & ":" & NonSparkTypes.packet.To_String(strpersonalMessage) & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.IdTokenInfoType;

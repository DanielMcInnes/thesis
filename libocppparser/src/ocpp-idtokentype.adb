pragma SPARK_mode (on); 

with ocpp;
with ocpp.IdTokenType;
with Ada.Strings; use Ada.Strings;

package body ocpp.IdTokenType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.IdTokenType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      additionalInfoTypeArray.Initialize(self.additionalInfo);
      self.idToken := IdTokenTypeStrings.stridToken_t.To_Bounded_String("");
      self.zzztype := IdTokenEnumType.Central;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.IdTokenType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKey(msg, msgIndex, valid, "additionalInfo");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid IdTokenTypeadditionalInfo"); return; end if;

      additionalInfoTypeArray.FromString(msg, msgindex, self.additionalInfo, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid IdTokenTypeadditionalInfo"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "idToken", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenTypeidToken"); return; end if;

      self.idToken := IdTokenTypeStrings.stridToken_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "type", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid IdTokenTypetype"); return; end if;

      ocpp.IdTokenEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.zzztype, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid IdTokenTypetype"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid IdTokenTypetype"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      stradditionalInfo: NonSparkTypes.packet.Bounded_String;
      strtype : IdTokenEnumType.string_t.Bounded_String;
   begin
      additionalInfoTypeArray.To_Bounded_String(stradditionalInfo, self.additionalInfo);
      IdTokenEnumType.ToString(Self.zzztype, strtype);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "additionalInfo" & '"' & ": " & NonSparkTypes.packet.To_String(stradditionalInfo) & "," & ASCII.LF
                                                      & "    " & '"' & "idToken" & '"' & ": " & '"' & IdTokenTypeStrings.stridToken_t.To_String(Self.idToken) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "type" & '"' & ":"  & '"' & IdTokenEnumType.string_t.To_String(strtype) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.IdTokenType;

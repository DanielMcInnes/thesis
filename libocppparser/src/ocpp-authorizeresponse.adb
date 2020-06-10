pragma SPARK_mode (on); 

with ocpp;
with ocpp.AuthorizeResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.AuthorizeResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.AuthorizeResponse.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      IdTokenInfoType.Initialize(self.idTokenInfo);
      self.certificateStatus := AuthorizeCertificateStatusEnumType.Accepted;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.AuthorizeResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid AuthorizeResponsecertificateStatus messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid AuthorizeResponsecertificateStatus messageid"); return; end if;

      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid AuthorizeResponsecertificateStatus"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "idTokenInfo");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid AuthorizeResponseidTokenInfo"); return; end if;

      IdTokenInfoType.parse(msg, msgindex, self.idTokenInfo, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid AuthorizeResponseidTokenInfo"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "certificateStatus", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid AuthorizeResponsecertificateStatus"); return; end if;

      ocpp.AuthorizeCertificateStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.certificateStatus, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid AuthorizeResponsecertificateStatus"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid AuthorizeResponsecertificateStatus"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      stridTokenInfo : NonSparkTypes.packet.Bounded_String;
      strcertificateStatus : AuthorizeCertificateStatusEnumType.string_t.Bounded_String;
   begin
      IdTokenInfoType.To_Bounded_String(Self.idTokenInfo, stridTokenInfo);
      AuthorizeCertificateStatusEnumType.ToString(Self.certificateStatus, strcertificateStatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "idTokenInfo" & '"' & ":" & NonSparkTypes.packet.To_String(stridTokenInfo) & "," & ASCII.LF
                                                      & "       " & '"' & "certificateStatus" & '"' & ":"  & '"' & AuthorizeCertificateStatusEnumType.string_t.To_String(strcertificateStatus) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.AuthorizeResponse;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.AuthorizeRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.AuthorizeRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.AuthorizeRequest.T)
   is
   begin
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      IdTokenType.Initialize(self.idToken);
      iso15118CertificateHashDataTypeArray.Initialize(self.iso15118CertificateHashData);

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.AuthorizeRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid AuthorizeRequestiso15118CertificateHashData messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid AuthorizeRequestiso15118CertificateHashData messageid"); return; end if;

      ocpp.ParseAction(msg, msgindex, self.action, valid);
      if (valid = false) then NonSparkTypes.put_line("404 Invalid action"); return; end if; 

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid AuthorizeRequestiso15118CertificateHashData"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "idToken");
      if (valid = false) then NonSparkTypes.put_line("355 Invalid AuthorizeRequestidToken"); return; end if;

      IdTokenType.parse(msg, msgindex, self.idToken, valid);
      if (valid = false) then NonSparkTypes.put_line("357 Invalid AuthorizeRequestidToken"); return; end if;

      ocpp.findQuotedKey(msg, msgIndex, valid, "iso15118CertificateHashData");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid AuthorizeRequestiso15118CertificateHashData"); return; end if;

      iso15118CertificateHashDataTypeArray.FromString(msg, msgindex, self.iso15118CertificateHashData, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid AuthorizeRequestiso15118CertificateHashData"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid AuthorizeRequestiso15118CertificateHashData"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      stridToken : NonSparkTypes.packet.Bounded_String;
      striso15118CertificateHashData: NonSparkTypes.packet.Bounded_String;
   begin
      IdTokenType.To_Bounded_String(Self.idToken, stridToken);
      iso15118CertificateHashDataTypeArray.To_Bounded_String(striso15118CertificateHashData, self.iso15118CertificateHashData);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "idToken" & '"' & ":" & NonSparkTypes.packet.To_String(stridToken) & "," & ASCII.LF
                                                      & "    " & '"' & "iso15118CertificateHashData" & '"' & ": " & NonSparkTypes.packet.To_String(striso15118CertificateHashData) & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.AuthorizeRequest;

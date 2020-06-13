pragma SPARK_mode (on); 

with ocpp;
with ocpp.OCSPRequestDataType;
with Ada.Strings; use Ada.Strings;

package body ocpp.OCSPRequestDataType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.OCSPRequestDataType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.hashAlgorithm := HashAlgorithmEnumType.SHA256;
      self.issuerNameHash := OCSPRequestDataTypeStrings.strissuerNameHash_t.To_Bounded_String("");
      self.issuerKeyHash := OCSPRequestDataTypeStrings.strissuerKeyHash_t.To_Bounded_String("");
      self.serialNumber := OCSPRequestDataTypeStrings.strserialNumber_t.To_Bounded_String("");
      self.responderURL := OCSPRequestDataTypeStrings.strresponderURL_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.OCSPRequestDataType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "hashAlgorithm", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid OCSPRequestDataTypehashAlgorithm"); return; end if;

      ocpp.HashAlgorithmEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.hashAlgorithm, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid OCSPRequestDataTypehashAlgorithm"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "issuerNameHash", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid OCSPRequestDataTypeissuerNameHash"); return; end if;

      self.issuerNameHash := OCSPRequestDataTypeStrings.strissuerNameHash_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "issuerKeyHash", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid OCSPRequestDataTypeissuerKeyHash"); return; end if;

      self.issuerKeyHash := OCSPRequestDataTypeStrings.strissuerKeyHash_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "serialNumber", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid OCSPRequestDataTypeserialNumber"); return; end if;

      self.serialNumber := OCSPRequestDataTypeStrings.strserialNumber_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "responderURL", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid OCSPRequestDataTyperesponderURL"); return; end if;

      self.responderURL := OCSPRequestDataTypeStrings.strresponderURL_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid OCSPRequestDataTyperesponderURL"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strhashAlgorithm : HashAlgorithmEnumType.string_t.Bounded_String;
   begin
      HashAlgorithmEnumType.ToString(Self.hashAlgorithm, strhashAlgorithm);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "hashAlgorithm" & '"' & ":"  & '"' & HashAlgorithmEnumType.string_t.To_String(strhashAlgorithm) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "issuerNameHash" & '"' & ": " & '"' & OCSPRequestDataTypeStrings.strissuerNameHash_t.To_String(Self.issuerNameHash) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "issuerKeyHash" & '"' & ": " & '"' & OCSPRequestDataTypeStrings.strissuerKeyHash_t.To_String(Self.issuerKeyHash) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "serialNumber" & '"' & ": " & '"' & OCSPRequestDataTypeStrings.strserialNumber_t.To_String(Self.serialNumber) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "responderURL" & '"' & ": " & '"' & OCSPRequestDataTypeStrings.strresponderURL_t.To_String(Self.responderURL) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.OCSPRequestDataType;

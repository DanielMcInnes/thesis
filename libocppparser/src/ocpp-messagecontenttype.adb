pragma SPARK_mode (on); 

with ocpp;
with ocpp.MessageContentType;
with Ada.Strings; use Ada.Strings;

package body ocpp.MessageContentType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.MessageContentType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.format := MessageFormatEnumType.ASCII;
      self.language := NonSparkTypes.MessageContentType.strlanguage_t.To_Bounded_String("");
      self.content := NonSparkTypes.MessageContentType.strcontent_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.MessageContentType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "format", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid MessageContentTypeformat"); return; end if;

      ocpp.MessageFormatEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.format, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid MessageContentTypeformat"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "language", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid MessageContentTypelanguage"); return; end if;

      self.language := NonSparkTypes.MessageContentType.strlanguage_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "content", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid MessageContentTypecontent"); return; end if;

      self.content := NonSparkTypes.MessageContentType.strcontent_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid MessageContentTypecontent"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strformat : MessageFormatEnumType.string_t.Bounded_String;
   begin
      MessageFormatEnumType.ToString(Self.format, strformat);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "format" & '"' & ":"  & '"' & MessageFormatEnumType.string_t.To_String(strformat) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "language" & '"' & ": " & '"' & NonSparkTypes.MessageContentType.strlanguage_t.To_String(Self.language) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "content" & '"' & ": " & '"' & NonSparkTypes.MessageContentType.strcontent_t.To_String(Self.content) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.MessageContentType;

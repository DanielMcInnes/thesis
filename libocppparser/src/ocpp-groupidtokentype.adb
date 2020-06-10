pragma SPARK_mode (on); 

with ocpp;
with ocpp.GroupIdTokenType;
with Ada.Strings; use Ada.Strings;

package body ocpp.GroupIdTokenType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.GroupIdTokenType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.idToken := NonSparkTypes.GroupIdTokenType.stridToken_t.To_Bounded_String("");
      self.zzztype := IdTokenEnumType.Central;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.GroupIdTokenType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "idToken", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid GroupIdTokenTypeidToken"); return; end if;

      self.idToken := NonSparkTypes.GroupIdTokenType.stridToken_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "type", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid GroupIdTokenTypetype"); return; end if;

      ocpp.IdTokenEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.zzztype, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid GroupIdTokenTypetype"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GroupIdTokenTypetype"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strtype : IdTokenEnumType.string_t.Bounded_String;
   begin
      IdTokenEnumType.ToString(Self.zzztype, strtype);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "idToken" & '"' & ": " & '"' & NonSparkTypes.GroupIdTokenType.stridToken_t.To_String(Self.idToken) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "type" & '"' & ":"  & '"' & IdTokenEnumType.string_t.To_String(strtype) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.GroupIdTokenType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.AdditionalInfoType;
with Ada.Strings; use Ada.Strings;

package body ocpp.AdditionalInfoType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.AdditionalInfoType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.additionalIdToken := AdditionalInfoTypeStrings.stradditionalIdToken_t.To_Bounded_String("");
      self.zzztype := AdditionalInfoTypeStrings.strtype_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.AdditionalInfoType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "additionalIdToken", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid AdditionalInfoTypeadditionalIdToken"); return; end if;

      self.additionalIdToken := AdditionalInfoTypeStrings.stradditionalIdToken_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "type", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid AdditionalInfoTypetype"); return; end if;

      self.zzztype := AdditionalInfoTypeStrings.strtype_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid AdditionalInfoTypetype"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "additionalIdToken" & '"' & ": " & '"' & AdditionalInfoTypeStrings.stradditionalIdToken_t.To_String(Self.additionalIdToken) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "type" & '"' & ": " & '"' & AdditionalInfoTypeStrings.strtype_t.To_String(Self.zzztype) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.AdditionalInfoType;

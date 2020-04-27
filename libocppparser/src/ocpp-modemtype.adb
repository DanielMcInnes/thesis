pragma SPARK_mode (on); 

with ocpp;
with ocpp.ModemType;
with Ada.Strings; use Ada.Strings;

package body ocpp.ModemType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.ModemType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "iccid", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.iccid, valid);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "imsi", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      stringType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.imsi, valid);

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      striccid : undefinedType.string_t.Bounded_string;
      strimsi : undefinedType.string_t.Bounded_string;
   begin
      undefinedType.ToString(Self.iccid, striccid);
      undefinedType.ToString(Self.imsi, strimsi);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "iccid" & '"' & ": " & '"' & undefinedType.string_t.To_String(striccid) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "imsi" & '"' & ": " & '"' & undefinedType.string_t.To_String(strimsi) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.[object Object];

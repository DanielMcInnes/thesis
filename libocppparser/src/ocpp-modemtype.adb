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

   procedure Initialize(self: out ocpp.ModemType.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.zzzArrayElementInitialized := False;
      self.iccid := NonSparkTypes.ModemType.striccid_t.To_Bounded_String("");
      self.imsi := NonSparkTypes.ModemType.strimsi_t.To_Bounded_String("");

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.ModemType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "iccid", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ModemTypeiccid"); return; end if;

      self.iccid := NonSparkTypes.ModemType.striccid_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "imsi", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid ModemTypeimsi"); return; end if;

      self.imsi := NonSparkTypes.ModemType.strimsi_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid ModemTypeimsi"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "iccid" & '"' & ": " & '"' & NonSparkTypes.ModemType.striccid_t.To_String(Self.iccid) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "imsi" & '"' & ": " & '"' & NonSparkTypes.ModemType.strimsi_t.To_String(Self.imsi) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.ModemType;

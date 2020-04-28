pragma SPARK_mode (on); 

with ocpp;
with ocpp.ComponentType;
with Ada.Strings; use Ada.Strings;

package body ocpp.ComponentType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.ComponentType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "evse", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      EVSEType.parse(msg, msgindex, self.evse, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "name", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.name := NonSparkTypes.ComponentType.strname_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "instance", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      self.instance := NonSparkTypes.ComponentType.strinstance_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strevse : NonSparkTypes.packet.Bounded_String;
   begin
      EVSEType.To_Bounded_String(Self.evse, strevse);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "evse" & '"' & ":" & NonSparkTypes.packet.To_String(strevse) & "," & ASCII.LF
                                                      & "    " & '"' & "name" & '"' & ": " & '"' & NonSparkTypes.ComponentType.strname_t.To_String(Self.name) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "instance" & '"' & ": " & '"' & NonSparkTypes.ComponentType.strinstance_t.To_String(Self.instance) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.ComponentType;

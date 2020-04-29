pragma SPARK_mode (on); 

with ocpp;
with ocpp.EVSEType;
with Ada.Strings; use Ada.Strings;

package body ocpp.EVSEType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.EVSEType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "id", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid EVSETypeid"); return; end if;
      self.id := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "connectorId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid EVSETypeconnectorId"); return; end if;
      self.connectorId := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid EVSETypeconnectorId"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "id" & '"' & ": " & Self.id'Image & "," & ASCII.LF
                                                      & "    " & '"' & "connectorId" & '"' & ": " & Self.connectorId'Image & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.EVSEType;

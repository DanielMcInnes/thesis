pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetBaseReportResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetBaseReportResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.GetBaseReportResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid GetBaseReportResponse"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "status", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid GetBaseReportResponse"); return; end if;

      GenericDeviceModelStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), self.status, valid);

      if (valid = false) then NonSparkTypes.put_line("Invalid GetBaseReportResponse"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strstatus : GenericDeviceModelStatusEnumType.string_t.Bounded_string;
   begin
      GenericDeviceModelStatusEnumType.ToString(Self.status, strstatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "status" & '"' & ": " & '"' & GenericDeviceModelStatusEnumType.string_t.To_String(strstatus) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetBaseReportResponse;

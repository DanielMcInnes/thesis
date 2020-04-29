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

   procedure Initialize(self: out ocpp.GetBaseReportResponse.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.status := Accepted;

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.GetBaseReportResponse.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid GetBaseReportResponsestatus messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid GetBaseReportResponsestatus messageid"); return; end if;

      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid GetBaseReportResponsestatus"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "status", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid GetBaseReportResponsestatus"); return; end if;

      ocpp.GenericDeviceModelStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.status, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid GetBaseReportResponsestatus"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GetBaseReportResponsestatus"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strstatus : GenericDeviceModelStatusEnumType.string_t.Bounded_String;
   begin
      GenericDeviceModelStatusEnumType.ToString(Self.status, strstatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "status" & '"' & ":"  & '"' & GenericDeviceModelStatusEnumType.string_t.To_String(strstatus) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetBaseReportResponse;

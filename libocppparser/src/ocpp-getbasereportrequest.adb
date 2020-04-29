pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetBaseReportRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetBaseReportRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.GetBaseReportRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      self.requestId := -1;
      self.reportBase := ConfigurationInventory;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.GetBaseReportRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid GetBaseReportRequestreportBase messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid GetBaseReportRequestreportBase messageid"); return; end if;

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid GetBaseReportRequestreportBase"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "requestId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid GetBaseReportRequestrequestId"); return; end if;
      self.requestId := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "reportBase", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid GetBaseReportRequestreportBase"); return; end if;

      ocpp.ReportBaseEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.reportBase, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid GetBaseReportRequestreportBase"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid GetBaseReportRequestreportBase"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strreportBase : ReportBaseEnumType.string_t.Bounded_String;
   begin
      ReportBaseEnumType.ToString(Self.reportBase, strreportBase);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "requestId" & '"' & ": " & Self.requestId'Image & "," & ASCII.LF
                                                      & "       " & '"' & "reportBase" & '"' & ":"  & '"' & ReportBaseEnumType.string_t.To_String(strreportBase) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetBaseReportRequest;

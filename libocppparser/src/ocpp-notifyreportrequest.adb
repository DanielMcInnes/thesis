pragma SPARK_mode (on); 

with ocpp;
with ocpp.NotifyReportRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.NotifyReportRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.NotifyReportRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      self.requestId := -1;
      self.generatedAt := NonSparkTypes.NotifyReportRequest.strgeneratedAt_t.To_Bounded_String("");
      reportDataTypeArray.Initialize(self.reportData);
      self.tbc := False;
      self.seqNo := -1;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.NotifyReportRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid NotifyReportRequestseqNo messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid NotifyReportRequestseqNo messageid"); return; end if;

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid NotifyReportRequestseqNo"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "requestId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid NotifyReportRequestrequestId"); return; end if;
      self.requestId := dummyInt;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "generatedAt", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid NotifyReportRequestgeneratedAt"); return; end if;

      self.generatedAt := NonSparkTypes.NotifyReportRequest.strgeneratedAt_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKey(msg, msgIndex, valid, "reportData");
      if (valid = false) then NonSparkTypes.put_line("345 Invalid NotifyReportRequestreportData"); return; end if;

      ReportDataTypeArray.FromString(msg, msgindex, self.reportData, valid);
      if (valid = false) then NonSparkTypes.put_line("347 Invalid NotifyReportRequestreportData"); return; end if;


      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "seqNo", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid NotifyReportRequestseqNo"); return; end if;
      self.seqNo := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid NotifyReportRequestseqNo"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strreportData: NonSparkTypes.packet.Bounded_String;
   begin
      ReportDataTypeArray.To_Bounded_String(strreportData, self.reportData);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "requestId" & '"' & ": " & Self.requestId'Image & "," & ASCII.LF
                                                      & "    " & '"' & "generatedAt" & '"' & ": " & '"' & NonSparkTypes.NotifyReportRequest.strgeneratedAt_t.To_String(Self.generatedAt) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "reportData" & '"' & ": " & NonSparkTypes.packet.To_String(strreportData) & "," & ASCII.LF
                                                      & "    " & '"' & "tbc" & '"' & ": " & Self.tbc'Image & "," & ASCII.LF
                                                      & "    " & '"' & "seqNo" & '"' & ": " & Self.seqNo'Image & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.NotifyReportRequest;

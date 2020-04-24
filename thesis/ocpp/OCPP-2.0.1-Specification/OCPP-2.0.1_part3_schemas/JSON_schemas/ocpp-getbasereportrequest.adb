pragma SPARK_mode (on); 

with ocpp.GetBaseReportRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetBaseReportRequest is 
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   packet: in ocpp.GetBaseReportRequest.T;
                   valid: out Boolean
                  )
   is
   begin
      checkValid(msg, msgindex, packet, action, valid);
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      strreportBase : ReportBaseEnumType.string_t.Bounded_string;
   begin
      ReportBaseEnumType.ToString(Self.reportBase, strreportBase);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "requestId" & '"' & ": " & Self.requestId'Image & "," & ASCII.LF
                                                      & "    " & '"' & "reportBase" & '"' & ": " & '"' & ReportBaseEnumType.string_t.To_String(strreportBase) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetBaseReportRequest;

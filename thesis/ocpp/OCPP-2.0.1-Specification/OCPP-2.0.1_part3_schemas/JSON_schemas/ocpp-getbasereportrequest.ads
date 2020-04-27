pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.ReportBaseEnumType; use ocpp.ReportBaseEnumType;

package ocpp.GetBaseReportRequest is
   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("GetBaseReport"); 
   type T is new call with record
      requestId : integer;
      reportBase : string;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.GetBaseReportRequest.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex, self),
                msgindex => (msg, msgIndex, self),
                self  => (msg, msgindex, self)
               ),
    post => (if valid = true then
               (self.messagetypeid = 2) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0) and
               (self.action = action) -- prove that the original packet contains the corresponding "action"
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.GetBaseReportRequest;
pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.CustomDataType; use ocpp.CustomDataType;
with ocpp.ReportBaseEnumType; use ocpp.ReportBaseEnumType;

package ocpp.GetBaseReportRequest is
   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("GetBaseReport"); 
   type T is new call with record
      customData : CustomDataType.T;
      requestId : integer;
      reportBase : ReportBaseEnumType.T;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                packet: in out ocpp.GetBaseReportRequest.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                  msgindex => (msg, msgindex, packet),
                packet => (msg, msgindex, packet),
                valid => (msg, msgindex, packet)
               ),
    post => (if valid = true then
               (packet.messagetypeid = 2) and
               (NonSparkTypes.messageid_t.Length(packet.messageid) > 0) and
               (packet.action = action) and
               (Index(NonSparkTypes.packet.To_String(msg), NonSparkTypes.action_t.To_String(action)) /= 0) -- prove that the original packet contains the corresponding "action"
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.GetBaseReportRequest;
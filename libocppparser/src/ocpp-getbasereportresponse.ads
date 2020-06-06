pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.GenericDeviceModelStatusEnumType; use ocpp.GenericDeviceModelStatusEnumType;

package ocpp.GetBaseReportResponse is
   type T is new callresult with record
      status : GenericDeviceModelStatusEnumType.T;
   end record;
   procedure Initialize(self: out ocpp.GetBaseReportResponse.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  out Integer;
                self: out ocpp.GetBaseReportResponse.T;
                valid: out Boolean
               )
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (
                valid => (msg),
                msgindex => (msg),
                self  => (msg)
),
    post => (if valid = true then
               (self.messagetypeid = 3) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.GetBaseReportResponse;
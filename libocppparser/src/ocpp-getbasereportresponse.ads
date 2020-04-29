pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.GenericDeviceModelStatusEnumType; use ocpp.GenericDeviceModelStatusEnumType;

package ocpp.GetBaseReportResponse is
   type T is new callresult with record
      status : GenericDeviceModelStatusEnumType.T;
   end record;
   procedure Initialize(self: out ocpp.GetBaseReportResponse.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: out ocpp.GetBaseReportResponse.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgIndex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.GetBaseReportResponse;
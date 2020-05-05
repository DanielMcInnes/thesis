pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.ChargingStationType; use ocpp.ChargingStationType;
with ocpp.BootReasonEnumType; use ocpp.BootReasonEnumType;

package ocpp.BootNotificationRequest is
   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("BootNotification"); 
   type T is new call with record
      chargingStation : ChargingStationType.T;
      reason : BootReasonEnumType.T;
   end record;
   procedure Initialize(self: out ocpp.BootNotificationRequest.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  out Integer;
                self: out ocpp.BootNotificationRequest.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg),
                msgindex => (msg),
                self  => (msg)
),
    post => (if valid = true then
               (self.messagetypeid = 2) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0) and
               (self.action = action) -- prove that the original packet contains the corresponding "action"
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.BootNotificationRequest;
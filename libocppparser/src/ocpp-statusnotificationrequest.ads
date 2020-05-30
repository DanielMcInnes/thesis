pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.ConnectorStatusEnumType; use ocpp.ConnectorStatusEnumType;

package ocpp.StatusNotificationRequest is
   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("StatusNotification"); 
   type T is new call with record
      timestamp : NonSparkTypes.StatusNotificationRequest.strtimestamp_t.Bounded_String;
      connectorStatus : ConnectorStatusEnumType.T;
      evseId : integer;
      connectorId : integer;
   end record;
   procedure Initialize(self: out ocpp.StatusNotificationRequest.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  out Integer;
                self: out ocpp.StatusNotificationRequest.T;
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
               (self.messagetypeid = 2) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0) and
               (self.action = action) -- prove that the original packet contains the corresponding "action"
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.StatusNotificationRequest;
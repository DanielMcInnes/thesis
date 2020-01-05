pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Command_Line;
with ocpp;
with NonSparkTypes;
use NonSparkTypes.bootnotification_t;

package ocpp.BootNotification --with Annotate => (GNATprove, Terminating)
is
   strBootNotification : constant String := "BootNotification";

   type Request is new call with record
      reason: NonSparkTypes.BootReasonEnumType.Bounded_String := NonSparkTypes.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
      chargingStation: ChargingStation_t;
   end record;

   type Response is new callresult with record
      currentTime: NonSparkTypes.bootnotification_t.response.currentTime.Bounded_String := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
      interval:  NonSparkTypes.bootnotification_t.response.interval.Bounded_String := NonSparkTypes.bootnotification_t.response.interval.To_Bounded_String(""); -- eg. 300
      status: NonSparkTypes.bootnotification_t.response.status.Bounded_String := NonSparkTypes.bootnotification_t.response.status.To_Bounded_String(""); -- eg. Accepted
   end record;

   type BootReasons_t is array(1..9) of NonSparkTypes.BootReasonEnumType.Bounded_String;
   validreasons : constant BootReasons_t := (NonSparkTypes.BootReasonEnumType.To_Bounded_String("ApplicationReset"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("FirmwareUpdate"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("LocalReset"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("PowerUp"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("RemoteReset"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("ScheduledReset"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("Triggered"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("Unknown"),
                                             NonSparkTypes.BootReasonEnumType.To_Bounded_String("Watchdog"));

   procedure DefaultInitialize(Self : out ocpp.BootNotification.Request);

   procedure validreason(thereason: in NonSparkTypes.BootReasonEnumType.Bounded_String;
                         valid: out Boolean)
     with  Global => null;

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   request: in out ocpp.BootNotification.Request;
                   valid: out Boolean
                  )
     with
       Global => null,
       Depends => (
                     request => (msg, request),
                   valid => (msg, request)
                  ),
     post => (if valid = true then
                (request.messagetypeid = 2) and
                  (NonSparkTypes.messageid_t.Length(request.messageid) > 0) and
                (NonSparkTypes.action_t.To_String(request.action) = strBootNotification) and
                  (Index(NonSparkTypes.packet.To_String(msg), strBootNotification) /= 0) -- prove that the original packet contains "BootNotification"
             );

   procedure To_Bounded_String(Self: in ocpp.BootNotification.Request;
                               retval: out NonSparkTypes.packet.Bounded_String);

end ocpp.BootNotification;

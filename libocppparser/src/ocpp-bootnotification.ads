pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
--with Ada.Text_IO;
with Ada.Command_Line;
with ocpp;
use ocpp.bootnotification_t;

package ocpp.BootNotification --with Annotate => (GNATprove, Terminating)
is
   package modemType is

   end modemType;

   strBootNotification : constant String := "BootNotification";


   type Response is new callresult with record
      currentTime: ocpp.BootNotification_t.response.currentTime.Bounded_String := ocpp.BootNotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
      interval:  ocpp.BootNotification_t.response.interval.Bounded_String := ocpp.BootNotification_t.response.interval.To_Bounded_String(""); -- eg. 300
      status: ocpp.BootNotification_t.response.status.Bounded_String := ocpp.BootNotification_t.response.status.To_Bounded_String(""); -- eg. Accepted
   end record;

   type BootReasons_t is array(1..9) of ocpp.BootReasonEnumType.Bounded_String;
   validreasons : constant BootReasons_t := (ocpp.BootReasonEnumType.To_Bounded_String("ApplicationReset"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("FirmwareUpdate"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("LocalReset"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("PowerUp"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("RemoteReset"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("ScheduledReset"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("Triggered"),
                                               ocpp.BootReasonEnumType.To_Bounded_String("Unknown"),
                                             ocpp.BootReasonEnumType.To_Bounded_String("Watchdog"));

   procedure validreason(thereason: in ocpp.BootReasonEnumType.Bounded_String;
                        valid: out Boolean)
     with  Global => null;

   procedure parse(msg: in ocpp.packet.Bounded_String;
                   request: out ocpp.Request;
                   valid: out Boolean)
     with Global => null,
     Depends => (
                 request => msg,
                 valid => msg
                ),
     post => (if valid = true then
                (request.messagetypeid = 2) and
                  (ocpp.messageid_t.Length(request.messageid) > 0) and
                (ocpp.action_t.To_String(request.action) = "BootNotification") and
                  (Index(ocpp.packet.To_String(msg), strBootNotification) /= 0) -- prove that the original packet contains "BootNotification"
             );


end ocpp.BootNotification;

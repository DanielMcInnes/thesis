pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Text_IO;
with Ada.Command_Line;
with ocpp;
use ocpp.bootnotification_t;

package ocpp.BootNotification is

   type Request is new call with record
      reason: ocpp.BootNotification_t.request.reason.Bounded_String := ocpp.BootNotification_t.request.reason.To_Bounded_String(""); --eg. PowerUp
      --ApplicationReset - The Charging Station rebooted due to an application error.
      --FirmwareUpdate - The Charging Station rebooted due to a firmware update.
      --LocalReset - The Charging Station rebooted due to a local reset command.
      --PowerUp - The Charging Station powered up and registers itself with the CSMS.
      --RemoteReset - The Charging Station rebooted due to a remote reset command.
      --ScheduledReset -The Charging Station rebooted due to a scheduled reset command.
      --Triggered - Requested by the CSMS via a TriggerMessage
      --Unknown - The boot reason is unknown.
      --Watchdog -The Charging Station rebooted due to an elapsed watchdog timer.

      model:  ocpp.BootNotification_t.request.model.Bounded_String := ocpp.BootNotification_t.request.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendor: ocpp.BootNotification_t.request.vendor.Bounded_String := ocpp.BootNotification_t.request.vendor.To_Bounded_String(""); -- eg. VendorX
   end record;

   type Response is new callresult with record
      currentTime: ocpp.BootNotification_t.response.currentTime.Bounded_String := ocpp.BootNotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
      interval:  ocpp.BootNotification_t.response.interval.Bounded_String := ocpp.BootNotification_t.response.interval.To_Bounded_String(""); -- eg. 300
      status: ocpp.BootNotification_t.response.status.Bounded_String := ocpp.BootNotification_t.response.status.To_Bounded_String(""); -- eg. Accepted
   end record;

   type BootReasons_t is array(1..9) of ocpp.BootNotification_t.request.reason.Bounded_String;
   validreasons : constant BootReasons_t := (ocpp.BootNotification_t.request.reason.To_Bounded_String("ApplicationReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("FirmwareUpdate"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("LocalReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("PowerUp"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("RemoteReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("ScheduledReset"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("Triggered"),
                                               ocpp.BootNotification_t.request.reason.To_Bounded_String("Unknown"),
                                             ocpp.BootNotification_t.request.reason.To_Bounded_String("Watchdog"));

   procedure validreason(thereason: in ocpp.BootNotification_t.request.reason.Bounded_String;
                        valid: out Boolean)
     with  Global => null;

   procedure parse(msg: in ocpp.packet.Bounded_String;
                   request: out ocpp.BootNotification.Request;
                   valid: out Boolean)
     with Global => (in_out => Ada.Text_IO.File_System),
     Depends => (
                   request => (msg, Ada.Text_IO.File_System),
                 valid => (msg, Ada.Text_IO.File_System),
                 Ada.Text_IO.File_System => (msg, Ada.Text_IO.File_System)
                ),
     post => (if valid = true then
                (request.messagetypeid = 2) and
                  (ocpp.messageid_t.Length(request.messageid) > 0) and
                (ocpp.action_t.To_String(request.action) = "BootNotification")
             );


end ocpp.BootNotification;

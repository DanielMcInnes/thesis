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
      model:  ocpp.BootNotification_t.request.model.Bounded_String := ocpp.BootNotification_t.request.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendor: ocpp.BootNotification_t.request.vendor.Bounded_String := ocpp.BootNotification_t.request.vendor.To_Bounded_String(""); -- eg. VendorX
   end record;

   type Response is new callresult with record
      currentTime: ocpp.BootNotification_t.response.currentTime.Bounded_String := ocpp.BootNotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
      interval:  ocpp.BootNotification_t.response.interval.Bounded_String := ocpp.BootNotification_t.response.interval.To_Bounded_String(""); -- eg. 300
      status: ocpp.BootNotification_t.response.status.Bounded_String := ocpp.BootNotification_t.response.status.To_Bounded_String(""); -- eg. Accepted
   end record;

   type BootReasons_t is array(1..9) of ocpp.BootNotification_t.request.reason.Bounded_String;

   procedure parse(msg: in ocpp.packet.Bounded_String;
                   bn: out ocpp.BootNotification.Request)
     with Global => (In_Out => Ada.Text_IO.File_System);
end ocpp.BootNotification;

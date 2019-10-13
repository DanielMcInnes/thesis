pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Text_IO;
with Ada.Command_Line;
with ocpp;

package ocpp.BootNotification is

   type Request is new call with record
      reason: ocpp.BootNotification_t.reason.Bounded_String := ocpp.BootNotification_t.reason.To_Bounded_String(""); --eg. PowerUp
      model:  ocpp.BootNotification_t.model.Bounded_String := ocpp.BootNotification_t.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendor: ocpp.BootNotification_t.vendor.Bounded_String := ocpp.BootNotification_t.vendor.To_Bounded_String(""); -- eg. VendorX
   end record;

   type Response is new callresult with record
      temp: Integer;
--      currentTime: ocpp.BootNotificationreason.Bounded_String := ocpp.BootNotificationreason.To_Bounded_String(""); --eg. PowerUp
--      interval:  ocpp.BootNotificationmodel.Bounded_String := ocpp.BootNotificationmodel.To_Bounded_String(""); -- eg. SingleSocketCharger
--      status: ocpp.BootNotificationvendor.Bounded_String := ocpp.BootNotificationvendor.To_Bounded_String(""); -- eg. VendorX
   end record;

   type BootReasons_t is array(1..9) of ocpp.BootNotification_t.reason.Bounded_String;

   procedure parse(msg: in ocpp.packet.Bounded_String;
                   bn: out ocpp.BootNotification.Request)
     with Global => (In_Out => Ada.Text_IO.File_System);
end ocpp.BootNotification;

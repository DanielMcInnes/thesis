pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Text_IO;
with Ada.Command_Line;
with ocpp;

package ocpp.BootNotifications is
   type BootNotification is tagged record
      reason: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      model:  ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      vendor: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
   end record;
   procedure parse(msg: in ocpp.packet.Bounded_String;
                  bn: out ocpp.BootNotifications.BootNotification);

   type BootReasons_t is array(1..9) of ocpp.packet.Bounded_String;

end ocpp.BootNotifications;

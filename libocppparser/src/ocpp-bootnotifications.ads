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
      messageTypeId: Integer := 0; -- eg. 2, 3
      messageId: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      action: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");   end record;

   type BootReasons_t is array(1..9) of ocpp.packet.Bounded_String;

   procedure parse(msg: in ocpp.packet.Bounded_String;
                   bn: out ocpp.BootNotifications.BootNotification)
     with Global => (In_Out => Ada.Text_IO.File_System);--, Output => );
end ocpp.BootNotifications;

pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Text_IO;
with Ada.Command_Line;
with ocpp;

--with ocpp.packet; use ocpp.packet;

package ocpp.BootNotifications is
   type BootNotification is tagged record
      reason: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String("");
      br1 : ocpp.packet.Bounded_String;
      model: ocpp.packet.Bounded_String;
      vendor: ocpp.packet.Bounded_String;
   end record;
   bnr : aliased BootNotification;

   type ptr is access all BootNotification;

   function Isa(msg: in out ocpp.packet.Bounded_String) return Boolean;
   function parse(self: ptr;
                  msg: in out ocpp.packet.Bounded_String) return Boolean;
   package br is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   type BootReasons_t is array(1..9) of ocpp.packet.Bounded_String;

end ocpp.BootNotifications;

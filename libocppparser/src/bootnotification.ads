pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package BootNotification is

   function IsBootNotificationRequest(msg: Ada.Strings.Bounded.Generic_Bounded_Length (Max => 20)) return Integer;

end BootNotification;

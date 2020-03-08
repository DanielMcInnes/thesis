-- start ocppMonitorEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MonitorEnumType is
   type T is (
      UpperThreshold,
      LowerThreshold,
      zzzDelta,
      Periodic,
      PeriodicClockAligned
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MonitorEnumType;
-- end ocpp-MonitorEnumType.ads

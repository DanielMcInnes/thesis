-- start ocppMonitoringCriterionEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MonitoringCriterionEnumType is
   type T is (
      ThresholdMonitoring,
      zzzDeltaMonitoring,
      PeriodicMonitoring
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 19);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MonitoringCriterionEnumType;
-- end ocpp-MonitoringCriterionEnumType.ads

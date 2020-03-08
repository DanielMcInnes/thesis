-- ocpp-MonitoringCriterionEnumType.adb

with ocpp.MonitoringCriterionEnumType; use ocpp.MonitoringCriterionEnumType;
with NonSparkTypes;

package body ocpp.MonitoringCriterionEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ThresholdMonitoring")) then
         attribute := ThresholdMonitoring;
      elsif (NonSparkTypes.Uncased_Equals(str, "DeltaMonitoring")) then
         attribute := zzzDeltaMonitoring;
      elsif (NonSparkTypes.Uncased_Equals(str, "PeriodicMonitoring")) then
         attribute := PeriodicMonitoring;
      else
         valid := false;
         return;
      end if;
      valid := true;
   end FromString;

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
   is
      use string_t;
   begin
      case attribute is
         when ThresholdMonitoring => str := To_Bounded_String("ThresholdMonitoring");
         when zzzDeltaMonitoring => str := To_Bounded_String("DeltaMonitoring");
         when PeriodicMonitoring => str := To_Bounded_String("PeriodicMonitoring");
      end case;
   end ToString;
end ocpp.MonitoringCriterionEnumType;

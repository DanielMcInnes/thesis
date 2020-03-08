-- ocpp-MonitorEnumType.adb

with ocpp.MonitorEnumType; use ocpp.MonitorEnumType;
with NonSparkTypes;

package body ocpp.MonitorEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "UpperThreshold")) then
         attribute := UpperThreshold;
      elsif (NonSparkTypes.Uncased_Equals(str, "LowerThreshold")) then
         attribute := LowerThreshold;
      elsif (NonSparkTypes.Uncased_Equals(str, "Delta")) then
         attribute := zzzDelta;
      elsif (NonSparkTypes.Uncased_Equals(str, "Periodic")) then
         attribute := Periodic;
      elsif (NonSparkTypes.Uncased_Equals(str, "PeriodicClockAligned")) then
         attribute := PeriodicClockAligned;
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
         when UpperThreshold => str := To_Bounded_String("UpperThreshold");
         when LowerThreshold => str := To_Bounded_String("LowerThreshold");
         when zzzDelta => str := To_Bounded_String("Delta");
         when Periodic => str := To_Bounded_String("Periodic");
         when PeriodicClockAligned => str := To_Bounded_String("PeriodicClockAligned");
      end case;
   end ToString;
end ocpp.MonitorEnumType;

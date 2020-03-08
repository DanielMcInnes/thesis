-- ocpp-BootReasonEnumType.adb

with ocpp.BootReasonEnumType; use ocpp.BootReasonEnumType;
with NonSparkTypes;

package body ocpp.BootReasonEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ApplicationReset")) then
         attribute := ApplicationReset;
      elsif (NonSparkTypes.Uncased_Equals(str, "FirmwareUpdate")) then
         attribute := FirmwareUpdate;
      elsif (NonSparkTypes.Uncased_Equals(str, "LocalReset")) then
         attribute := LocalReset;
      elsif (NonSparkTypes.Uncased_Equals(str, "PowerUp")) then
         attribute := PowerUp;
      elsif (NonSparkTypes.Uncased_Equals(str, "RemoteReset")) then
         attribute := RemoteReset;
      elsif (NonSparkTypes.Uncased_Equals(str, "ScheduledReset")) then
         attribute := ScheduledReset;
      elsif (NonSparkTypes.Uncased_Equals(str, "Triggered")) then
         attribute := Triggered;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unknown")) then
         attribute := Unknown;
      elsif (NonSparkTypes.Uncased_Equals(str, "Watchdog")) then
         attribute := Watchdog;
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
         when ApplicationReset => str := To_Bounded_String("ApplicationReset");
         when FirmwareUpdate => str := To_Bounded_String("FirmwareUpdate");
         when LocalReset => str := To_Bounded_String("LocalReset");
         when PowerUp => str := To_Bounded_String("PowerUp");
         when RemoteReset => str := To_Bounded_String("RemoteReset");
         when ScheduledReset => str := To_Bounded_String("ScheduledReset");
         when Triggered => str := To_Bounded_String("Triggered");
         when Unknown => str := To_Bounded_String("Unknown");
         when Watchdog => str := To_Bounded_String("Watchdog");
      end case;
   end ToString;
end ocpp.BootReasonEnumType;

-- ocpp-EventNotificationEnumType.adb

with ocpp.EventNotificationEnumType; use ocpp.EventNotificationEnumType;
with NonSparkTypes;

package body ocpp.EventNotificationEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "HardWiredNotification")) then
         attribute := HardWiredNotification;
      elsif (NonSparkTypes.Uncased_Equals(str, "HardWiredMonitor")) then
         attribute := HardWiredMonitor;
      elsif (NonSparkTypes.Uncased_Equals(str, "PreconfiguredMonitor")) then
         attribute := PreconfiguredMonitor;
      elsif (NonSparkTypes.Uncased_Equals(str, "CustomMonitor")) then
         attribute := CustomMonitor;
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
         when HardWiredNotification => str := To_Bounded_String("HardWiredNotification");
         when HardWiredMonitor => str := To_Bounded_String("HardWiredMonitor");
         when PreconfiguredMonitor => str := To_Bounded_String("PreconfiguredMonitor");
         when CustomMonitor => str := To_Bounded_String("CustomMonitor");
      end case;
   end ToString;
end ocpp.EventNotificationEnumType;

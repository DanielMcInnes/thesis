-- start ocppEventNotificationEnumType.ads
with Ada.Strings.Bounded;

package ocpp.EventNotificationEnumType is
   type T is (
      HardWiredNotification,
      HardWiredMonitor,
      PreconfiguredMonitor,
      CustomMonitor
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 21);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.EventNotificationEnumType;
-- end ocpp-EventNotificationEnumType.ads

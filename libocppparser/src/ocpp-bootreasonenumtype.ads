-- start ocppBootReasonEnumType.ads
with Ada.Strings.Bounded;

package ocpp.BootReasonEnumType is
   type T is (
      ApplicationReset,
      FirmwareUpdate,
      LocalReset,
      PowerUp,
      RemoteReset,
      ScheduledReset,
      Triggered,
      Unknown,
      Watchdog
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 16);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.BootReasonEnumType;
-- end ocpp-BootReasonEnumType.ads

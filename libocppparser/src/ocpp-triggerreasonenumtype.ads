-- start ocppTriggerReasonEnumType.ads
with Ada.Strings.Bounded;

package ocpp.TriggerReasonEnumType is
   type T is (
      Authorized,
      CablePluggedIn,
      ChargingRateChanged,
      ChargingStateChanged,
      Deauthorized,
      EnergyLimitReached,
      EVCommunicationLost,
      EVConnectTimeout,
      MeterValueClock,
      MeterValuePeriodic,
      TimeLimitReached,
      Trigger,
      UnlockCommand,
      StopAuthorized,
      EVDeparted,
      EVDetected,
      RemoteStop,
      RemoteStart,
      AbnormalCondition,
      SignedDataReceived,
      ResetCommand
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.TriggerReasonEnumType;
-- end ocpp-TriggerReasonEnumType.ads

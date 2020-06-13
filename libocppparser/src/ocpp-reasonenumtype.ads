-- start ocppReasonEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ReasonEnumType is
   type T is (
      DeAuthorized,
      EmergencyStop,
      EnergyLimitReached,
      EVDisconnected,
      GroundFault,
      ImmediateReset,
      Local,
      LocalOutOfCredit,
      MasterPass,
      Other,
      OvercurrentFault,
      PowerLoss,
      PowerQuality,
      Reboot,
      Remote,
      SOCLimitReached,
      StoppedByEV,
      TimeLimitReached,
      Timeout
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 18);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.ReasonEnumType;
-- end ocpp-ReasonEnumType.ads

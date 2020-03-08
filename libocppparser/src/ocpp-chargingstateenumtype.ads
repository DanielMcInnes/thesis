-- start ocppChargingStateEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ChargingStateEnumType is
   type T is (
      Charging,
      EVDetected,
      SuspendedEV,
      SuspendedEVSE
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 13);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ChargingStateEnumType;
-- end ocpp-ChargingStateEnumType.ads

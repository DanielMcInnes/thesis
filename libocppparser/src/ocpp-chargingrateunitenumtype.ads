-- start ocppChargingRateUnitEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ChargingRateUnitEnumType is
   type T is (
      W,
      A
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 1);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ChargingRateUnitEnumType;
-- end ocpp-ChargingRateUnitEnumType.ads

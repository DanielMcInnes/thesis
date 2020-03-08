-- start ocppChargingLimitSourceEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ChargingLimitSourceEnumType is
   type T is (
      EMS,
      Other,
      SO,
      CSO
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ChargingLimitSourceEnumType;
-- end ocpp-ChargingLimitSourceEnumType.ads

-- start ocppChargingProfilePurposeEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ChargingProfilePurposeEnumType is
   type T is (
      ChargingStationExternalConstraints,
      ChargingStationMaxProfile,
      TxDefaultProfile,
      TxProfile
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 34);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ChargingProfilePurposeEnumType;
-- end ocpp-ChargingProfilePurposeEnumType.ads

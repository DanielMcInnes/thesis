-- start ocppEnergyTransferModeEnumType.ads
with Ada.Strings.Bounded;

package ocpp.EnergyTransferModeEnumType is
   type T is (
      DC,
      AC_single_phase,
      AC_two_phase,
      AC_three_phase
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.EnergyTransferModeEnumType;
-- end ocpp-EnergyTransferModeEnumType.ads

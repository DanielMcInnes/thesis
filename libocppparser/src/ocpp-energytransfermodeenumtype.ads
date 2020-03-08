-- start ocppEnergyTransferModeEnumType.ads
with Ada.Strings.Bounded;

package ocpp.EnergyTransferModeEnumType is
   type T is (
      AC_single_phase_core,
      AC_three_phase_core,
      DC_combo_core,
      DC_core,
      DC_extended,
      DC_unique
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.EnergyTransferModeEnumType;
-- end ocpp-EnergyTransferModeEnumType.ads

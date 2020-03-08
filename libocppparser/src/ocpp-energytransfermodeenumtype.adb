-- ocpp-EnergyTransferModeEnumType.adb

with ocpp.EnergyTransferModeEnumType; use ocpp.EnergyTransferModeEnumType;
with NonSparkTypes;

package body ocpp.EnergyTransferModeEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "AC_single_phase_core")) then
         attribute := AC_single_phase_core;
      elsif (NonSparkTypes.Uncased_Equals(str, "AC_three_phase_core")) then
         attribute := AC_three_phase_core;
      elsif (NonSparkTypes.Uncased_Equals(str, "DC_combo_core")) then
         attribute := DC_combo_core;
      elsif (NonSparkTypes.Uncased_Equals(str, "DC_core")) then
         attribute := DC_core;
      elsif (NonSparkTypes.Uncased_Equals(str, "DC_extended")) then
         attribute := DC_extended;
      elsif (NonSparkTypes.Uncased_Equals(str, "DC_unique")) then
         attribute := DC_unique;
      else
         valid := false;
         return;
      end if;
      valid := true;
   end FromString;

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
   is
      use string_t;
   begin
      case attribute is
         when AC_single_phase_core => str := To_Bounded_String("AC_single_phase_core");
         when AC_three_phase_core => str := To_Bounded_String("AC_three_phase_core");
         when DC_combo_core => str := To_Bounded_String("DC_combo_core");
         when DC_core => str := To_Bounded_String("DC_core");
         when DC_extended => str := To_Bounded_String("DC_extended");
         when DC_unique => str := To_Bounded_String("DC_unique");
      end case;
   end ToString;
end ocpp.EnergyTransferModeEnumType;

-- ocpp-EnergyTransferModeEnumType.adb

with ocpp.EnergyTransferModeEnumType; use ocpp.EnergyTransferModeEnumType;
with NonSparkTypes;

package body ocpp.EnergyTransferModeEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "DC")) then
         attribute := DC;
      elsif (NonSparkTypes.Uncased_Equals(str, "AC_single_phase")) then
         attribute := AC_single_phase;
      elsif (NonSparkTypes.Uncased_Equals(str, "AC_two_phase")) then
         attribute := AC_two_phase;
      elsif (NonSparkTypes.Uncased_Equals(str, "AC_three_phase")) then
         attribute := AC_three_phase;
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
         when DC => str := To_Bounded_String("DC");
         when AC_single_phase => str := To_Bounded_String("AC_single_phase");
         when AC_two_phase => str := To_Bounded_String("AC_two_phase");
         when AC_three_phase => str := To_Bounded_String("AC_three_phase");
      end case;
   end ToString;
end ocpp.EnergyTransferModeEnumType;

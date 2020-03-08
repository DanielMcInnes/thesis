-- ocpp-CostKindEnumType.adb

with ocpp.CostKindEnumType; use ocpp.CostKindEnumType;
with NonSparkTypes;

package body ocpp.CostKindEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "CarbonDioxideEmission")) then
         attribute := CarbonDioxideEmission;
      elsif (NonSparkTypes.Uncased_Equals(str, "RelativePricePercentage")) then
         attribute := RelativePricePercentage;
      elsif (NonSparkTypes.Uncased_Equals(str, "RenewableGenerationPercentage")) then
         attribute := RenewableGenerationPercentage;
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
         when CarbonDioxideEmission => str := To_Bounded_String("CarbonDioxideEmission");
         when RelativePricePercentage => str := To_Bounded_String("RelativePricePercentage");
         when RenewableGenerationPercentage => str := To_Bounded_String("RenewableGenerationPercentage");
      end case;
   end ToString;
end ocpp.CostKindEnumType;

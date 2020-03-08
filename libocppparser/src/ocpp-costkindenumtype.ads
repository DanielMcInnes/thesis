-- start ocppCostKindEnumType.ads
with Ada.Strings.Bounded;

package ocpp.CostKindEnumType is
   type T is (
      CarbonDioxideEmission,
      RelativePricePercentage,
      RenewableGenerationPercentage
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 29);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.CostKindEnumType;
-- end ocpp-CostKindEnumType.ads

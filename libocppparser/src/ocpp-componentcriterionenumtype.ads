-- start ocppComponentCriterionEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ComponentCriterionEnumType is
   type T is (
      Active,
      Available,
      Enabled,
      Problem
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ComponentCriterionEnumType;
-- end ocpp-ComponentCriterionEnumType.ads

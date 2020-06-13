pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package AdditionalInfoTypeStrings is
   package stradditionalIdToken_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package strtype_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
end AdditionalInfoTypeStrings;
pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package IdTokenInfoTypeStrings is
   package strstatus_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strcacheExpiryDateTime_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strlanguage1_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
   package strlanguage2_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
end IdTokenInfoTypeStrings;
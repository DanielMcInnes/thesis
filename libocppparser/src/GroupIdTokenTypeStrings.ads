pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package GroupIdTokenTypeStrings is
   package stridToken_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package strtype_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end GroupIdTokenTypeStrings;
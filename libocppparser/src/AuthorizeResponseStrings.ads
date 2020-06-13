pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package AuthorizeResponseStrings is
   package strcertificateStatus_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end AuthorizeResponseStrings;
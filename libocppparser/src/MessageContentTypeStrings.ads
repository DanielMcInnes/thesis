pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package MessageContentTypeStrings is
   package strformat_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strlanguage_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
   package strcontent_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 512);
end MessageContentTypeStrings;
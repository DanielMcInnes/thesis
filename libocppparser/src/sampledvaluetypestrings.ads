--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package SampledValueTypeStrings is
   package strcontext_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strmeasurand_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strphase_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strlocation_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end SampledValueTypeStrings;
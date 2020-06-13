--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package MeterValueTypeStrings is
   package strtimestamp_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end MeterValueTypeStrings;
--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package VariableTypeStrings is
   package strname_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   package strinstance_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
end VariableTypeStrings;
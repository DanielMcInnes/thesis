--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package SetVariableDataTypeStrings is
   package strattributeType_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strattributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 1000);
end SetVariableDataTypeStrings;
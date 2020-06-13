pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package SetVariableResultTypeStrings is
   package strattributeType_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strattributeStatus_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end SetVariableResultTypeStrings;
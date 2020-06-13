pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package GetVariableResultTypeStrings is
   package strattributeStatus_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strattributeType_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strattributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 2500);
end GetVariableResultTypeStrings;
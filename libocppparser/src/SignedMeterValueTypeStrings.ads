pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package SignedMeterValueTypeStrings is
   package strsignedMeterData_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 2500);
   package strsigningMethod_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   package strencodingMethod_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   package strpublicKey_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 2500);
end SignedMeterValueTypeStrings;
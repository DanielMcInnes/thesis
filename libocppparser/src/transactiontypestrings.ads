--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package TransactionTypeStrings is
   package strtransactionId_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package strchargingState_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strstoppedReason_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end TransactionTypeStrings;
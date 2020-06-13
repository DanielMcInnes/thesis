--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package TransactionEventRequestStrings is
   package streventType_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strtimestamp_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strtriggerReason_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end TransactionEventRequestStrings;
pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package ModemTypeStrings is
   package striccid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   package strimsi_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
end ModemTypeStrings;
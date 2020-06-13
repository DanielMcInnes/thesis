--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package OCSPRequestDataTypeStrings is
   package strhashAlgorithm_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
   package strissuerNameHash_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 128);
   package strissuerKeyHash_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 128);
   package strserialNumber_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 40);
   package strresponderURL_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 512);
end OCSPRequestDataTypeStrings;
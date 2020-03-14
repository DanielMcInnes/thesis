-- start ocppHashAlgorithmEnumType.ads
with Ada.Strings.Bounded;

package ocpp.HashAlgorithmEnumType is
   type T is (
      SHA256,
      SHA384,
      SHA512
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 6);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.HashAlgorithmEnumType;
-- end ocpp-HashAlgorithmEnumType.ads
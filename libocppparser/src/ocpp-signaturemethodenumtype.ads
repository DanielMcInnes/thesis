-- start ocppSignatureMethodEnumType.ads
with Ada.Strings.Bounded;

package ocpp.SignatureMethodEnumType is
   type T is (
      ECDSAP256SHA256,
      ECDSAP384SHA384,
      ECDSA192SHA256
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.SignatureMethodEnumType;
-- end ocpp-SignatureMethodEnumType.ads

-- start ocppCertificateStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.CertificateStatusEnumType is
   type T is (
      Accepted,
      SignatureError,
      CertificateExpired,
      CertificateRevoked,
      NoCertificateAvailable,
      CertChainError,
      ContractCancelled
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 22);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.CertificateStatusEnumType;
-- end ocpp-CertificateStatusEnumType.ads

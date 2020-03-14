-- start ocppAuthorizeCertificateStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.AuthorizeCertificateStatusEnumType is
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
end ocpp.AuthorizeCertificateStatusEnumType;
-- end ocpp-AuthorizeCertificateStatusEnumType.ads

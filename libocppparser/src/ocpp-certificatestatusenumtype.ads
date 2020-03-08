with Ada.Strings.Bounded;

--CertificateStatusEnumType is used by: authorize:AuthorizeResponse , installCertificate:InstallCertificateResponse
package ocpp.CertificateStatusEnumType is
   type T is (Invalid,
              Accepted,
              SignatureError,
              CertificateExpired,
              CertificateRevoked,
              NoCertificateAvailable,
              CertChainError,
              ContractCancelled
             );
      
   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
      
end ocpp.CertificateStatusEnumType;

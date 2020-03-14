-- start ocppCertificateActionEnumType.ads
with Ada.Strings.Bounded;

package ocpp.CertificateActionEnumType is
   type T is (
      Install,
      Update
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 7);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.CertificateActionEnumType;
-- end ocpp-CertificateActionEnumType.ads

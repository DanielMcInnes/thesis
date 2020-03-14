-- start ocppCertificateSigningUseEnumType.ads
with Ada.Strings.Bounded;

package ocpp.CertificateSigningUseEnumType is
   type T is (
      ChargingStationCertificate,
      V2GCertificate
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 26);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.CertificateSigningUseEnumType;
-- end ocpp-CertificateSigningUseEnumType.ads

-- start ocppInstallCertificateUseEnumType.ads
with Ada.Strings.Bounded;

package ocpp.InstallCertificateUseEnumType is
   type T is (
      V2GRootCertificate,
      MORootCertificate,
      CSMSRootCertificate,
      ManufacturerRootCertificate
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 27);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.InstallCertificateUseEnumType;
-- end ocpp-InstallCertificateUseEnumType.ads
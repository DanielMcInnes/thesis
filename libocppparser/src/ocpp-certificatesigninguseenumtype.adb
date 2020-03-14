-- ocpp-CertificateSigningUseEnumType.adb

with ocpp.CertificateSigningUseEnumType; use ocpp.CertificateSigningUseEnumType;
with NonSparkTypes;

package body ocpp.CertificateSigningUseEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ChargingStationCertificate")) then
         attribute := ChargingStationCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "V2GCertificate")) then
         attribute := V2GCertificate;
      else
         valid := false;
         return;
      end if;
      valid := true;
   end FromString;

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
   is
      use string_t;
   begin
      case attribute is
         when ChargingStationCertificate => str := To_Bounded_String("ChargingStationCertificate");
         when V2GCertificate => str := To_Bounded_String("V2GCertificate");
      end case;
   end ToString;
end ocpp.CertificateSigningUseEnumType;

-- ocpp-GetCertificateIdUseEnumType.adb

with ocpp.GetCertificateIdUseEnumType; use ocpp.GetCertificateIdUseEnumType;
with NonSparkTypes;

package body ocpp.GetCertificateIdUseEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "V2GRootCertificate")) then
         attribute := V2GRootCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "MORootCertificate")) then
         attribute := MORootCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "CSMSRootCertificate")) then
         attribute := CSMSRootCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "V2GCertificateChain")) then
         attribute := V2GCertificateChain;
      elsif (NonSparkTypes.Uncased_Equals(str, "ManufacturerRootCertificate")) then
         attribute := ManufacturerRootCertificate;
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
         when V2GRootCertificate => str := To_Bounded_String("V2GRootCertificate");
         when MORootCertificate => str := To_Bounded_String("MORootCertificate");
         when CSMSRootCertificate => str := To_Bounded_String("CSMSRootCertificate");
         when V2GCertificateChain => str := To_Bounded_String("V2GCertificateChain");
         when ManufacturerRootCertificate => str := To_Bounded_String("ManufacturerRootCertificate");
      end case;
   end ToString;
end ocpp.GetCertificateIdUseEnumType;

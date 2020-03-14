-- ocpp-AuthorizeCertificateStatusEnumType.adb

with ocpp.AuthorizeCertificateStatusEnumType; use ocpp.AuthorizeCertificateStatusEnumType;
with NonSparkTypes;

package body ocpp.AuthorizeCertificateStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "SignatureError")) then
         attribute := SignatureError;
      elsif (NonSparkTypes.Uncased_Equals(str, "CertificateExpired")) then
         attribute := CertificateExpired;
      elsif (NonSparkTypes.Uncased_Equals(str, "CertificateRevoked")) then
         attribute := CertificateRevoked;
      elsif (NonSparkTypes.Uncased_Equals(str, "NoCertificateAvailable")) then
         attribute := NoCertificateAvailable;
      elsif (NonSparkTypes.Uncased_Equals(str, "CertChainError")) then
         attribute := CertChainError;
      elsif (NonSparkTypes.Uncased_Equals(str, "ContractCancelled")) then
         attribute := ContractCancelled;
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
         when Accepted => str := To_Bounded_String("Accepted");
         when SignatureError => str := To_Bounded_String("SignatureError");
         when CertificateExpired => str := To_Bounded_String("CertificateExpired");
         when CertificateRevoked => str := To_Bounded_String("CertificateRevoked");
         when NoCertificateAvailable => str := To_Bounded_String("NoCertificateAvailable");
         when CertChainError => str := To_Bounded_String("CertChainError");
         when ContractCancelled => str := To_Bounded_String("ContractCancelled");
      end case;
   end ToString;
end ocpp.AuthorizeCertificateStatusEnumType;

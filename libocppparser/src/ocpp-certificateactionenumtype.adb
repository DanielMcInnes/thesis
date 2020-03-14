-- ocpp-CertificateActionEnumType.adb

with ocpp.CertificateActionEnumType; use ocpp.CertificateActionEnumType;
with NonSparkTypes;

package body ocpp.CertificateActionEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Install")) then
         attribute := Install;
      elsif (NonSparkTypes.Uncased_Equals(str, "Update")) then
         attribute := Update;
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
         when Install => str := To_Bounded_String("Install");
         when Update => str := To_Bounded_String("Update");
      end case;
   end ToString;
end ocpp.CertificateActionEnumType;

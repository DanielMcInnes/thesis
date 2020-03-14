-- ocpp-UpdateFirmwareStatusEnumType.adb

with ocpp.UpdateFirmwareStatusEnumType; use ocpp.UpdateFirmwareStatusEnumType;
with NonSparkTypes;

package body ocpp.UpdateFirmwareStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "AcceptedCanceled")) then
         attribute := AcceptedCanceled;
      elsif (NonSparkTypes.Uncased_Equals(str, "InvalidCertificate")) then
         attribute := InvalidCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "RevokedCertificate")) then
         attribute := RevokedCertificate;
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
         when Rejected => str := To_Bounded_String("Rejected");
         when AcceptedCanceled => str := To_Bounded_String("AcceptedCanceled");
         when InvalidCertificate => str := To_Bounded_String("InvalidCertificate");
         when RevokedCertificate => str := To_Bounded_String("RevokedCertificate");
      end case;
   end ToString;
end ocpp.UpdateFirmwareStatusEnumType;

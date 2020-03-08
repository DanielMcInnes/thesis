-- ocpp-SignatureMethodEnumType.adb

with ocpp.SignatureMethodEnumType; use ocpp.SignatureMethodEnumType;
with NonSparkTypes;

package body ocpp.SignatureMethodEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ECDSAP256SHA256")) then
         attribute := ECDSAP256SHA256;
      elsif (NonSparkTypes.Uncased_Equals(str, "ECDSAP384SHA384")) then
         attribute := ECDSAP384SHA384;
      elsif (NonSparkTypes.Uncased_Equals(str, "ECDSA192SHA256")) then
         attribute := ECDSA192SHA256;
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
         when ECDSAP256SHA256 => str := To_Bounded_String("ECDSAP256SHA256");
         when ECDSAP384SHA384 => str := To_Bounded_String("ECDSAP384SHA384");
         when ECDSA192SHA256 => str := To_Bounded_String("ECDSA192SHA256");
      end case;
   end ToString;
end ocpp.SignatureMethodEnumType;

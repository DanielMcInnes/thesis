-- ocpp-HashAlgorithmEnumType.adb

with ocpp.HashAlgorithmEnumType; use ocpp.HashAlgorithmEnumType;
with NonSparkTypes;

package body ocpp.HashAlgorithmEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "SHA256")) then
         attribute := SHA256;
      elsif (NonSparkTypes.Uncased_Equals(str, "SHA384")) then
         attribute := SHA384;
      elsif (NonSparkTypes.Uncased_Equals(str, "SHA512")) then
         attribute := SHA512;
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
         when SHA256 => str := To_Bounded_String("SHA256");
         when SHA384 => str := To_Bounded_String("SHA384");
         when SHA512 => str := To_Bounded_String("SHA512");
      end case;
   end ToString;
end ocpp.HashAlgorithmEnumType;

-- ocpp-CustomerInformationStatusEnumType.adb

with ocpp.CustomerInformationStatusEnumType; use ocpp.CustomerInformationStatusEnumType;
with NonSparkTypes;

package body ocpp.CustomerInformationStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "Invalid")) then
         attribute := Invalid;
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
         when Invalid => str := To_Bounded_String("Invalid");
      end case;
   end ToString;
end ocpp.CustomerInformationStatusEnumType;

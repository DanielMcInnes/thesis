-- ocpp-ChargingProfileKindEnumType.adb

with ocpp.ChargingProfileKindEnumType; use ocpp.ChargingProfileKindEnumType;
with NonSparkTypes;

package body ocpp.ChargingProfileKindEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Absolute")) then
         attribute := Absolute;
      elsif (NonSparkTypes.Uncased_Equals(str, "Recurring")) then
         attribute := Recurring;
      elsif (NonSparkTypes.Uncased_Equals(str, "Relative")) then
         attribute := Relative;
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
         when Absolute => str := To_Bounded_String("Absolute");
         when Recurring => str := To_Bounded_String("Recurring");
         when Relative => str := To_Bounded_String("Relative");
      end case;
   end ToString;
end ocpp.ChargingProfileKindEnumType;

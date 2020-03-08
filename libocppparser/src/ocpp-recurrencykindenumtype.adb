-- ocpp-RecurrencyKindEnumType.adb

with ocpp.RecurrencyKindEnumType; use ocpp.RecurrencyKindEnumType;
with NonSparkTypes;

package body ocpp.RecurrencyKindEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Daily")) then
         attribute := Daily;
      elsif (NonSparkTypes.Uncased_Equals(str, "Weekly")) then
         attribute := Weekly;
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
         when Daily => str := To_Bounded_String("Daily");
         when Weekly => str := To_Bounded_String("Weekly");
      end case;
   end ToString;
end ocpp.RecurrencyKindEnumType;

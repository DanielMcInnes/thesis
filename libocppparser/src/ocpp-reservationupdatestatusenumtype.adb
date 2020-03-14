-- ocpp-ReservationUpdateStatusEnumType.adb

with ocpp.ReservationUpdateStatusEnumType; use ocpp.ReservationUpdateStatusEnumType;
with NonSparkTypes;

package body ocpp.ReservationUpdateStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Expired")) then
         attribute := Expired;
      elsif (NonSparkTypes.Uncased_Equals(str, "Removed")) then
         attribute := Removed;
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
         when Expired => str := To_Bounded_String("Expired");
         when Removed => str := To_Bounded_String("Removed");
      end case;
   end ToString;
end ocpp.ReservationUpdateStatusEnumType;

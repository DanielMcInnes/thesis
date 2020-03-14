-- ocpp-ReserveNowStatusEnumType.adb

with ocpp.ReserveNowStatusEnumType; use ocpp.ReserveNowStatusEnumType;
with NonSparkTypes;

package body ocpp.ReserveNowStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Faulted")) then
         attribute := Faulted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Occupied")) then
         attribute := Occupied;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unavailable")) then
         attribute := Unavailable;
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
         when Faulted => str := To_Bounded_String("Faulted");
         when Occupied => str := To_Bounded_String("Occupied");
         when Rejected => str := To_Bounded_String("Rejected");
         when Unavailable => str := To_Bounded_String("Unavailable");
      end case;
   end ToString;
end ocpp.ReserveNowStatusEnumType;

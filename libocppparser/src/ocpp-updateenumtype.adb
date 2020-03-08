-- ocpp-UpdateEnumType.adb

with ocpp.UpdateEnumType; use ocpp.UpdateEnumType;
with NonSparkTypes;

package body ocpp.UpdateEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Differential")) then
         attribute := Differential;
      elsif (NonSparkTypes.Uncased_Equals(str, "Full")) then
         attribute := Full;
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
         when Differential => str := To_Bounded_String("Differential");
         when Full => str := To_Bounded_String("Full");
      end case;
   end ToString;
end ocpp.UpdateEnumType;

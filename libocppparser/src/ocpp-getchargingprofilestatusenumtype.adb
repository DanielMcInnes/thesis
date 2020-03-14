-- ocpp-GetChargingProfileStatusEnumType.adb

with ocpp.GetChargingProfileStatusEnumType; use ocpp.GetChargingProfileStatusEnumType;
with NonSparkTypes;

package body ocpp.GetChargingProfileStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "NoProfiles")) then
         attribute := NoProfiles;
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
         when NoProfiles => str := To_Bounded_String("NoProfiles");
      end case;
   end ToString;
end ocpp.GetChargingProfileStatusEnumType;

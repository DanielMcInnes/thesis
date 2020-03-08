-- ocpp-ChargingRateUnitEnumType.adb

with ocpp.ChargingRateUnitEnumType; use ocpp.ChargingRateUnitEnumType;
with NonSparkTypes;

package body ocpp.ChargingRateUnitEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "W")) then
         attribute := W;
      elsif (NonSparkTypes.Uncased_Equals(str, "A")) then
         attribute := A;
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
         when W => str := To_Bounded_String("W");
         when A => str := To_Bounded_String("A");
      end case;
   end ToString;
end ocpp.ChargingRateUnitEnumType;

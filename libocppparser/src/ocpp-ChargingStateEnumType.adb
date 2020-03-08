-- ocpp-ChargingStateEnumType.adb

with ocpp.ChargingStateEnumType; use ocpp.ChargingStateEnumType;
with NonSparkTypes;

package body ocpp.ChargingStateEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Charging")) then
         attribute := Charging;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVDetected")) then
         attribute := EVDetected;
      elsif (NonSparkTypes.Uncased_Equals(str, "SuspendedEV")) then
         attribute := SuspendedEV;
      elsif (NonSparkTypes.Uncased_Equals(str, "SuspendedEVSE")) then
         attribute := SuspendedEVSE;
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
         when Charging => str := To_Bounded_String("Charging");
         when EVDetected => str := To_Bounded_String("EVDetected");
         when SuspendedEV => str := To_Bounded_String("SuspendedEV");
         when SuspendedEVSE => str := To_Bounded_String("SuspendedEVSE");
      end case;
   end ToString;
end ocpp.ChargingStateEnumType;
ChargingStateEnumType
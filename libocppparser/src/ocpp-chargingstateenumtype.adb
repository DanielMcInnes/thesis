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
      elsif (NonSparkTypes.Uncased_Equals(str, "EVConnected")) then
         attribute := EVConnected;
      elsif (NonSparkTypes.Uncased_Equals(str, "SuspendedEV")) then
         attribute := SuspendedEV;
      elsif (NonSparkTypes.Uncased_Equals(str, "SuspendedEVSE")) then
         attribute := SuspendedEVSE;
      elsif (NonSparkTypes.Uncased_Equals(str, "Idle")) then
         attribute := Idle;
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
         when EVConnected => str := To_Bounded_String("EVConnected");
         when SuspendedEV => str := To_Bounded_String("SuspendedEV");
         when SuspendedEVSE => str := To_Bounded_String("SuspendedEVSE");
         when Idle => str := To_Bounded_String("Idle");
      end case;
   end ToString;
end ocpp.ChargingStateEnumType;

-- ocpp-ChargingLimitSourceEnumType.adb

with ocpp.ChargingLimitSourceEnumType; use ocpp.ChargingLimitSourceEnumType;
with NonSparkTypes;

package body ocpp.ChargingLimitSourceEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "EMS")) then
         attribute := EMS;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other")) then
         attribute := Other;
      elsif (NonSparkTypes.Uncased_Equals(str, "SO")) then
         attribute := SO;
      elsif (NonSparkTypes.Uncased_Equals(str, "CSO")) then
         attribute := CSO;
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
         when EMS => str := To_Bounded_String("EMS");
         when Other => str := To_Bounded_String("Other");
         when SO => str := To_Bounded_String("SO");
         when CSO => str := To_Bounded_String("CSO");
      end case;
   end ToString;
end ocpp.ChargingLimitSourceEnumType;

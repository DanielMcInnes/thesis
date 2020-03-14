-- ocpp-MonitoringBaseEnumType.adb

with ocpp.MonitoringBaseEnumType; use ocpp.MonitoringBaseEnumType;
with NonSparkTypes;

package body ocpp.MonitoringBaseEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "All")) then
         attribute := zzzAll;
      elsif (NonSparkTypes.Uncased_Equals(str, "FactoryDefault")) then
         attribute := FactoryDefault;
      elsif (NonSparkTypes.Uncased_Equals(str, "HardWiredOnly")) then
         attribute := HardWiredOnly;
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
         when zzzAll => str := To_Bounded_String("All");
         when FactoryDefault => str := To_Bounded_String("FactoryDefault");
         when HardWiredOnly => str := To_Bounded_String("HardWiredOnly");
      end case;
   end ToString;
end ocpp.MonitoringBaseEnumType;

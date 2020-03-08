-- ocpp-SetMonitoringStatusEnumType.adb

with ocpp.SetMonitoringStatusEnumType; use ocpp.SetMonitoringStatusEnumType;
with NonSparkTypes;

package body ocpp.SetMonitoringStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownComponent")) then
         attribute := UnknownComponent;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownVariable")) then
         attribute := UnknownVariable;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnsupportedMonitorType")) then
         attribute := UnsupportedMonitorType;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "OutOfRange")) then
         attribute := OutOfRange;
      elsif (NonSparkTypes.Uncased_Equals(str, "Duplicate")) then
         attribute := Duplicate;
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
         when UnknownComponent => str := To_Bounded_String("UnknownComponent");
         when UnknownVariable => str := To_Bounded_String("UnknownVariable");
         when UnsupportedMonitorType => str := To_Bounded_String("UnsupportedMonitorType");
         when Rejected => str := To_Bounded_String("Rejected");
         when OutOfRange => str := To_Bounded_String("OutOfRange");
         when Duplicate => str := To_Bounded_String("Duplicate");
      end case;
   end ToString;
end ocpp.SetMonitoringStatusEnumType;

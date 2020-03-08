-- ocpp-EventTriggerEnumType.adb

with ocpp.EventTriggerEnumType; use ocpp.EventTriggerEnumType;
with NonSparkTypes;

package body ocpp.EventTriggerEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Alerting")) then
         attribute := Alerting;
      elsif (NonSparkTypes.Uncased_Equals(str, "Delta")) then
         attribute := zzzDelta;
      elsif (NonSparkTypes.Uncased_Equals(str, "Periodic")) then
         attribute := Periodic;
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
         when Alerting => str := To_Bounded_String("Alerting");
         when zzzDelta => str := To_Bounded_String("Delta");
         when Periodic => str := To_Bounded_String("Periodic");
      end case;
   end ToString;
end ocpp.EventTriggerEnumType;

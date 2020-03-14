-- ocpp-TriggerMessageStatusEnumType.adb

with ocpp.TriggerMessageStatusEnumType; use ocpp.TriggerMessageStatusEnumType;
with NonSparkTypes;

package body ocpp.TriggerMessageStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotImplemented")) then
         attribute := NotImplemented;
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
         when Rejected => str := To_Bounded_String("Rejected");
         when NotImplemented => str := To_Bounded_String("NotImplemented");
      end case;
   end ToString;
end ocpp.TriggerMessageStatusEnumType;

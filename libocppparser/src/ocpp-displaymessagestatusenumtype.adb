-- ocpp-DisplayMessageStatusEnumType.adb

with ocpp.DisplayMessageStatusEnumType; use ocpp.DisplayMessageStatusEnumType;
with NonSparkTypes;

package body ocpp.DisplayMessageStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedMessageFormat")) then
         attribute := NotSupportedMessageFormat;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedPriority")) then
         attribute := NotSupportedPriority;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedState")) then
         attribute := NotSupportedState;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownTransaction")) then
         attribute := UnknownTransaction;
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
         when NotSupportedMessageFormat => str := To_Bounded_String("NotSupportedMessageFormat");
         when Rejected => str := To_Bounded_String("Rejected");
         when NotSupportedPriority => str := To_Bounded_String("NotSupportedPriority");
         when NotSupportedState => str := To_Bounded_String("NotSupportedState");
         when UnknownTransaction => str := To_Bounded_String("UnknownTransaction");
      end case;
   end ToString;
end ocpp.DisplayMessageStatusEnumType;

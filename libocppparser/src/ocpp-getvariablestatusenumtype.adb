-- ocpp-GetVariableStatusEnumType.adb

with ocpp.GetVariableStatusEnumType; use ocpp.GetVariableStatusEnumType;
with NonSparkTypes;

package body ocpp.GetVariableStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownComponent")) then
         attribute := UnknownComponent;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownVariable")) then
         attribute := UnknownVariable;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedAttributeType")) then
         attribute := NotSupportedAttributeType;
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
         when UnknownComponent => str := To_Bounded_String("UnknownComponent");
         when UnknownVariable => str := To_Bounded_String("UnknownVariable");
         when NotSupportedAttributeType => str := To_Bounded_String("NotSupportedAttributeType");
      end case;
   end ToString;
end ocpp.GetVariableStatusEnumType;

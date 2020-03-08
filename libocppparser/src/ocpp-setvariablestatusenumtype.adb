-- ocpp-SetVariableStatusEnumType.adb

with ocpp.SetVariableStatusEnumType; use ocpp.SetVariableStatusEnumType;
with NonSparkTypes;

package body ocpp.SetVariableStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "InvalidValue")) then
         attribute := InvalidValue;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownComponent")) then
         attribute := UnknownComponent;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownVariable")) then
         attribute := UnknownVariable;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedAttributeType")) then
         attribute := NotSupportedAttributeType;
      elsif (NonSparkTypes.Uncased_Equals(str, "OutOfRange")) then
         attribute := OutOfRange;
      elsif (NonSparkTypes.Uncased_Equals(str, "RebootRequired")) then
         attribute := RebootRequired;
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
         when InvalidValue => str := To_Bounded_String("InvalidValue");
         when UnknownComponent => str := To_Bounded_String("UnknownComponent");
         when UnknownVariable => str := To_Bounded_String("UnknownVariable");
         when NotSupportedAttributeType => str := To_Bounded_String("NotSupportedAttributeType");
         when OutOfRange => str := To_Bounded_String("OutOfRange");
         when RebootRequired => str := To_Bounded_String("RebootRequired");
      end case;
   end ToString;
end ocpp.SetVariableStatusEnumType;

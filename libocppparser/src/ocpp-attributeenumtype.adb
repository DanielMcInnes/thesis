-- ocpp-AttributeEnumType.adb

with ocpp.AttributeEnumType; use ocpp.AttributeEnumType;
with NonSparkTypes;

package body ocpp.AttributeEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Actual")) then
         attribute := Actual;
      elsif (NonSparkTypes.Uncased_Equals(str, "Target")) then
         attribute := Target;
      elsif (NonSparkTypes.Uncased_Equals(str, "MinSet")) then
         attribute := MinSet;
      elsif (NonSparkTypes.Uncased_Equals(str, "MaxSet")) then
         attribute := MaxSet;
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
         when Actual => str := To_Bounded_String("Actual");
         when Target => str := To_Bounded_String("Target");
         when MinSet => str := To_Bounded_String("MinSet");
         when MaxSet => str := To_Bounded_String("MaxSet");
      end case;
   end ToString;
end ocpp.AttributeEnumType;

-- ocpp-ComponentCriterionEnumType.adb

with ocpp.ComponentCriterionEnumType; use ocpp.ComponentCriterionEnumType;
with NonSparkTypes;

package body ocpp.ComponentCriterionEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Active")) then
         attribute := Active;
      elsif (NonSparkTypes.Uncased_Equals(str, "Available")) then
         attribute := Available;
      elsif (NonSparkTypes.Uncased_Equals(str, "Enabled")) then
         attribute := Enabled;
      elsif (NonSparkTypes.Uncased_Equals(str, "Problem")) then
         attribute := Problem;
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
         when Active => str := To_Bounded_String("Active");
         when Available => str := To_Bounded_String("Available");
         when Enabled => str := To_Bounded_String("Enabled");
         when Problem => str := To_Bounded_String("Problem");
      end case;
   end ToString;
end ocpp.ComponentCriterionEnumType;

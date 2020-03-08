-- ocpp-MessageFormatEnumType.adb

with ocpp.MessageFormatEnumType; use ocpp.MessageFormatEnumType;
with NonSparkTypes;

package body ocpp.MessageFormatEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ASCII")) then
         attribute := ASCII;
      elsif (NonSparkTypes.Uncased_Equals(str, "HTML")) then
         attribute := HTML;
      elsif (NonSparkTypes.Uncased_Equals(str, "URI")) then
         attribute := URI;
      elsif (NonSparkTypes.Uncased_Equals(str, "UTF8")) then
         attribute := UTF8;
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
         when ASCII => str := To_Bounded_String("ASCII");
         when HTML => str := To_Bounded_String("HTML");
         when URI => str := To_Bounded_String("URI");
         when UTF8 => str := To_Bounded_String("UTF8");
      end case;
   end ToString;
end ocpp.MessageFormatEnumType;

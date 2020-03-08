-- ocpp-DataEnumType.adb

with ocpp.DataEnumType; use ocpp.DataEnumType;
with NonSparkTypes;

package body ocpp.DataEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "string")) then
         attribute := zzzstring;
      elsif (NonSparkTypes.Uncased_Equals(str, "decimal")) then
         attribute := decimal;
      elsif (NonSparkTypes.Uncased_Equals(str, "integer")) then
         attribute := integer;
      elsif (NonSparkTypes.Uncased_Equals(str, "dateTime")) then
         attribute := dateTime;
      elsif (NonSparkTypes.Uncased_Equals(str, "boolean")) then
         attribute := zzzboolean;
      elsif (NonSparkTypes.Uncased_Equals(str, "OptionList")) then
         attribute := OptionList;
      elsif (NonSparkTypes.Uncased_Equals(str, "SequenceList")) then
         attribute := SequenceList;
      elsif (NonSparkTypes.Uncased_Equals(str, "MemberList")) then
         attribute := MemberList;
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
         when zzzstring => str := To_Bounded_String("string");
         when decimal => str := To_Bounded_String("decimal");
         when integer => str := To_Bounded_String("integer");
         when dateTime => str := To_Bounded_String("dateTime");
         when zzzboolean => str := To_Bounded_String("boolean");
         when OptionList => str := To_Bounded_String("OptionList");
         when SequenceList => str := To_Bounded_String("SequenceList");
         when MemberList => str := To_Bounded_String("MemberList");
      end case;
   end ToString;
end ocpp.DataEnumType;

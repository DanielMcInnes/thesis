-- ocpp-MutabilityEnumType.adb

with ocpp.MutabilityEnumType; use ocpp.MutabilityEnumType;
with NonSparkTypes;

package body ocpp.MutabilityEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ReadOnly")) then
         attribute := ReadOnly;
      elsif (NonSparkTypes.Uncased_Equals(str, "WriteOnly")) then
         attribute := WriteOnly;
      elsif (NonSparkTypes.Uncased_Equals(str, "ReadWrite")) then
         attribute := ReadWrite;
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
         when ReadOnly => str := To_Bounded_String("ReadOnly");
         when WriteOnly => str := To_Bounded_String("WriteOnly");
         when ReadWrite => str := To_Bounded_String("ReadWrite");
      end case;
   end ToString;
end ocpp.MutabilityEnumType;

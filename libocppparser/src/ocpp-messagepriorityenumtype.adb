-- ocpp-MessagePriorityEnumType.adb

with ocpp.MessagePriorityEnumType; use ocpp.MessagePriorityEnumType;
with NonSparkTypes;

package body ocpp.MessagePriorityEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "AlwaysFront")) then
         attribute := AlwaysFront;
      elsif (NonSparkTypes.Uncased_Equals(str, "InFront")) then
         attribute := InFront;
      elsif (NonSparkTypes.Uncased_Equals(str, "NormalCycle")) then
         attribute := NormalCycle;
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
         when AlwaysFront => str := To_Bounded_String("AlwaysFront");
         when InFront => str := To_Bounded_String("InFront");
         when NormalCycle => str := To_Bounded_String("NormalCycle");
      end case;
   end ToString;
end ocpp.MessagePriorityEnumType;

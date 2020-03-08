-- ocpp-MessageStateEnumType.adb

with ocpp.MessageStateEnumType; use ocpp.MessageStateEnumType;
with NonSparkTypes;

package body ocpp.MessageStateEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Charging")) then
         attribute := Charging;
      elsif (NonSparkTypes.Uncased_Equals(str, "Faulted")) then
         attribute := Faulted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Idle")) then
         attribute := Idle;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unavailable")) then
         attribute := Unavailable;
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
         when Charging => str := To_Bounded_String("Charging");
         when Faulted => str := To_Bounded_String("Faulted");
         when Idle => str := To_Bounded_String("Idle");
         when Unavailable => str := To_Bounded_String("Unavailable");
      end case;
   end ToString;
end ocpp.MessageStateEnumType;

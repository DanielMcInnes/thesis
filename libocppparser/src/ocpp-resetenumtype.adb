-- ocpp-ResetEnumType.adb

with ocpp.ResetEnumType; use ocpp.ResetEnumType;
with NonSparkTypes;

package body ocpp.ResetEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Immediate")) then
         attribute := Immediate;
      elsif (NonSparkTypes.Uncased_Equals(str, "OnIdle")) then
         attribute := OnIdle;
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
         when Immediate => str := To_Bounded_String("Immediate");
         when OnIdle => str := To_Bounded_String("OnIdle");
      end case;
   end ToString;
end ocpp.ResetEnumType;

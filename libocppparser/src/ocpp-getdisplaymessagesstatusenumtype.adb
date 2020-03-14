-- ocpp-GetDisplayMessagesStatusEnumType.adb

with ocpp.GetDisplayMessagesStatusEnumType; use ocpp.GetDisplayMessagesStatusEnumType;
with NonSparkTypes;

package body ocpp.GetDisplayMessagesStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unknown")) then
         attribute := Unknown;
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
         when Unknown => str := To_Bounded_String("Unknown");
      end case;
   end ToString;
end ocpp.GetDisplayMessagesStatusEnumType;

-- ocpp-OperationalStatusEnumType.adb

with ocpp.OperationalStatusEnumType; use ocpp.OperationalStatusEnumType;
with NonSparkTypes;

package body ocpp.OperationalStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Inoperative")) then
         attribute := Inoperative;
      elsif (NonSparkTypes.Uncased_Equals(str, "Operative")) then
         attribute := Operative;
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
         when Inoperative => str := To_Bounded_String("Inoperative");
         when Operative => str := To_Bounded_String("Operative");
      end case;
   end ToString;
end ocpp.OperationalStatusEnumType;

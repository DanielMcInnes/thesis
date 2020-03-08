-- ocpp-OCPPInterfaceEnumType.adb

with ocpp.OCPPInterfaceEnumType; use ocpp.OCPPInterfaceEnumType;
with NonSparkTypes;

package body ocpp.OCPPInterfaceEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Wired0")) then
         attribute := Wired0;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wired1")) then
         attribute := Wired1;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wired2")) then
         attribute := Wired2;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wired3")) then
         attribute := Wired3;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wireless0")) then
         attribute := Wireless0;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wireless1")) then
         attribute := Wireless1;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wireless2")) then
         attribute := Wireless2;
      elsif (NonSparkTypes.Uncased_Equals(str, "Wireless3")) then
         attribute := Wireless3;
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
         when Wired0 => str := To_Bounded_String("Wired0");
         when Wired1 => str := To_Bounded_String("Wired1");
         when Wired2 => str := To_Bounded_String("Wired2");
         when Wired3 => str := To_Bounded_String("Wired3");
         when Wireless0 => str := To_Bounded_String("Wireless0");
         when Wireless1 => str := To_Bounded_String("Wireless1");
         when Wireless2 => str := To_Bounded_String("Wireless2");
         when Wireless3 => str := To_Bounded_String("Wireless3");
      end case;
   end ToString;
end ocpp.OCPPInterfaceEnumType;

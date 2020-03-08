-- ocpp-OCPPVersionEnumType.adb

with ocpp.OCPPVersionEnumType; use ocpp.OCPPVersionEnumType;
with NonSparkTypes;

package body ocpp.OCPPVersionEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "OCPP12")) then
         attribute := OCPP12;
      elsif (NonSparkTypes.Uncased_Equals(str, "OCPP15")) then
         attribute := OCPP15;
      elsif (NonSparkTypes.Uncased_Equals(str, "OCPP16")) then
         attribute := OCPP16;
      elsif (NonSparkTypes.Uncased_Equals(str, "OCPP20")) then
         attribute := OCPP20;
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
         when OCPP12 => str := To_Bounded_String("OCPP12");
         when OCPP15 => str := To_Bounded_String("OCPP15");
         when OCPP16 => str := To_Bounded_String("OCPP16");
         when OCPP20 => str := To_Bounded_String("OCPP20");
      end case;
   end ToString;
end ocpp.OCPPVersionEnumType;

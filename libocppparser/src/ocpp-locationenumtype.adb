-- ocpp-LocationEnumType.adb

with ocpp.LocationEnumType; use ocpp.LocationEnumType;
with NonSparkTypes;

package body ocpp.LocationEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Body")) then
         attribute := ABody;
      elsif (NonSparkTypes.Uncased_Equals(str, "Cable")) then
         attribute := Cable;
      elsif (NonSparkTypes.Uncased_Equals(str, "EV")) then
         attribute := EV;
      elsif (NonSparkTypes.Uncased_Equals(str, "Inlet")) then
         attribute := Inlet;
      elsif (NonSparkTypes.Uncased_Equals(str, "Outlet")) then
         attribute := Outlet;
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
         when ABody => str := To_Bounded_String("Body");
         when Cable => str := To_Bounded_String("Cable");
         when EV => str := To_Bounded_String("EV");
         when Inlet => str := To_Bounded_String("Inlet");
         when Outlet => str := To_Bounded_String("Outlet");
      end case;
   end ToString;
end ocpp.LocationEnumType;

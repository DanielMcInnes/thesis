-- ocpp-OCPPTransportEnumType.adb

with ocpp.OCPPTransportEnumType; use ocpp.OCPPTransportEnumType;
with NonSparkTypes;

package body ocpp.OCPPTransportEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "JSON")) then
         attribute := JSON;
      elsif (NonSparkTypes.Uncased_Equals(str, "SOAP")) then
         attribute := SOAP;
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
         when JSON => str := To_Bounded_String("JSON");
         when SOAP => str := To_Bounded_String("SOAP");
      end case;
   end ToString;
end ocpp.OCPPTransportEnumType;

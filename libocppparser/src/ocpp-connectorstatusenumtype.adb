with ocpp.ConnectorStatusEnumType; use ocpp.ConnectorStatusEnumType;
with NonSparkTypes;

package body ocpp.ConnectorStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin      
      if (NonSparkTypes.Uncased_Equals(str, "Invalid")) then
         attribute := Invalid;
         valid := false;
      elsif (NonSparkTypes.Uncased_Equals(str, "Available")) then
         attribute := Available;
      elsif (NonSparkTypes.Uncased_Equals(str, "Occupied")) then
         attribute := Occupied;
      elsif (NonSparkTypes.Uncased_Equals(str, "Reserved")) then
         attribute := Reserved;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unavailable")) then
         attribute := Unavailable;
      elsif (NonSparkTypes.Uncased_Equals(str, "Faulted")) then
         attribute := Faulted;
      else
         attribute := Invalid;
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
         when Invalid => str := To_Bounded_String("Invalid");
         when Available => str := To_Bounded_String("Available");
         when Occupied => str := To_Bounded_String("Occupied");
         when Reserved => str := To_Bounded_String("Reserved");
         when Unavailable => str := To_Bounded_String("Unavailable");
         when Faulted => str := To_Bounded_String("Faulted");
      end case;
   end ToString;
end ocpp.ConnectorStatusEnumType;

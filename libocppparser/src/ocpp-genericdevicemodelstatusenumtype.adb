with ocpp.GenericDeviceModelStatusEnumType;
with NonSparkTypes;

package body ocpp.GenericDeviceModelStatusEnumType is

   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Invalid")) then
         attribute := Invalid;
      elsif (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupported")) then
         attribute := NotSupported;
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
         when Accepted => str := To_Bounded_String("Accepted");
         when Rejected => str := To_Bounded_String("Rejected");
         when NotSupported => str := To_Bounded_String("NotSupported");
      end case;

   end ToString;
   

end ocpp.GenericDeviceModelStatusEnumType;

-- ocpp-UpdateStatusEnumType.adb

with ocpp.UpdateStatusEnumType; use ocpp.UpdateStatusEnumType;
with NonSparkTypes;

package body ocpp.UpdateStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Failed")) then
         attribute := Failed;
      elsif (NonSparkTypes.Uncased_Equals(str, "VersionMismatch")) then
         attribute := VersionMismatch;
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
         when Failed => str := To_Bounded_String("Failed");
         when VersionMismatch => str := To_Bounded_String("VersionMismatch");
      end case;
   end ToString;
end ocpp.UpdateStatusEnumType;

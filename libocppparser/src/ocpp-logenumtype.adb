-- ocpp-LogEnumType.adb

with ocpp.LogEnumType; use ocpp.LogEnumType;
with NonSparkTypes;

package body ocpp.LogEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "DiagnosticsLog")) then
         attribute := DiagnosticsLog;
      elsif (NonSparkTypes.Uncased_Equals(str, "SecurityLog")) then
         attribute := SecurityLog;
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
         when DiagnosticsLog => str := To_Bounded_String("DiagnosticsLog");
         when SecurityLog => str := To_Bounded_String("SecurityLog");
      end case;
   end ToString;
end ocpp.LogEnumType;

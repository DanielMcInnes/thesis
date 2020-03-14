-- ocpp-ReportBaseEnumType.adb

with ocpp.ReportBaseEnumType; use ocpp.ReportBaseEnumType;
with NonSparkTypes;

package body ocpp.ReportBaseEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ConfigurationInventory")) then
         attribute := ConfigurationInventory;
      elsif (NonSparkTypes.Uncased_Equals(str, "FullInventory")) then
         attribute := FullInventory;
      elsif (NonSparkTypes.Uncased_Equals(str, "SummaryInventory")) then
         attribute := SummaryInventory;
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
         when ConfigurationInventory => str := To_Bounded_String("ConfigurationInventory");
         when FullInventory => str := To_Bounded_String("FullInventory");
         when SummaryInventory => str := To_Bounded_String("SummaryInventory");
      end case;
   end ToString;
end ocpp.ReportBaseEnumType;

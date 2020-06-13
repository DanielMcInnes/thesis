--pragma SPARK_Mode (Off);

with Ada.Strings.Bounded;

package GetBaseReportRequestStrings is
   package strreportBase_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
end GetBaseReportRequestStrings;
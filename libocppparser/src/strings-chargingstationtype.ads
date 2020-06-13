pragma SPARK_Mode (Off);

with Ada.Strings;

package strings is
package ChargingStationType is
   package strserialNumber_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 25);
   package strmodel_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   package strvendorName_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   package strfirmwareVersion_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end ChargingStationType;
end strings;

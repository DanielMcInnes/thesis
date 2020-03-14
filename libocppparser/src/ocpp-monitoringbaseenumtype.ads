-- start ocppMonitoringBaseEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MonitoringBaseEnumType is
   type T is (
      All,
      FactoryDefault,
      HardWiredOnly
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 14);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MonitoringBaseEnumType;
-- end ocpp-MonitoringBaseEnumType.ads

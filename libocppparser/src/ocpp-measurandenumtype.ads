-- start ocppMeasurandEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MeasurandEnumType is
   type T is (
      Current_Export,
      Current_Import,
      Current_Offered,
      Energy_Active_Export_Register,
      Energy_Active_Import_Register,
      Energy_Reactive_Export_Register,
      Energy_Reactive_Import_Register,
      Energy_Active_Export_Interval,
      Energy_Active_Import_Interval,
      Energy_Active_Net,
      Energy_Reactive_Export_Interval,
      Energy_Reactive_Import_Interval,
      Energy_Reactive_Net,
      Energy_Apparent_Net,
      Energy_Apparent_Import,
      Energy_Apparent_Export,
      Frequency,
      Power_Active_Export,
      Power_Active_Import,
      Power_Factor,
      Power_Offered,
      Power_Reactive_Export,
      Power_Reactive_Import,
      SoC,
      Voltage
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 31);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MeasurandEnumType;
-- end ocpp-MeasurandEnumType.ads

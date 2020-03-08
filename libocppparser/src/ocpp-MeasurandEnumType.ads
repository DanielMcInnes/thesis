-- start ocppMeasurandEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MeasurandEnumType is
   type T is (
      Current.Export,
      Current.Import,
      Current.Offered,
      Energy.Active.Export.Register,
      Energy.Active.Import.Register,
      Energy.Reactive.Export.Register,
      Energy.Reactive.Import.Register,
      Energy.Active.Export.Interval,
      Energy.Active.Import.Interval,
      Energy.Active.Net,
      Energy.Reactive.Export.Interval,
      Energy.Reactive.Import.Interval,
      Energy.Reactive.Net,
      Energy.Apparent.Net,
      Energy.Apparent.Import,
      Energy.Apparent.Export,
      Frequency,
      Power.Active.Export,
      Power.Active.Import,
      Power.Factor,
      Power.Offered,
      Power.Reactive.Export,
      Power.Reactive.Import,
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

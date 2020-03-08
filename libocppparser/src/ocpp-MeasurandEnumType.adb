-- ocpp-MeasurandEnumType.adb

with ocpp.MeasurandEnumType; use ocpp.MeasurandEnumType;
with NonSparkTypes;

package body ocpp.MeasurandEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Current.Export")) then
         attribute := Current.Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Current.Import")) then
         attribute := Current.Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Current.Offered")) then
         attribute := Current.Offered;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Export.Register")) then
         attribute := Energy.Active.Export.Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Import.Register")) then
         attribute := Energy.Active.Import.Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Export.Register")) then
         attribute := Energy.Reactive.Export.Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Import.Register")) then
         attribute := Energy.Reactive.Import.Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Export.Interval")) then
         attribute := Energy.Active.Export.Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Import.Interval")) then
         attribute := Energy.Active.Import.Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Net")) then
         attribute := Energy.Active.Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Export.Interval")) then
         attribute := Energy.Reactive.Export.Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Import.Interval")) then
         attribute := Energy.Reactive.Import.Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Net")) then
         attribute := Energy.Reactive.Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Net")) then
         attribute := Energy.Apparent.Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Import")) then
         attribute := Energy.Apparent.Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Export")) then
         attribute := Energy.Apparent.Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Frequency")) then
         attribute := Frequency;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Active.Export")) then
         attribute := Power.Active.Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Active.Import")) then
         attribute := Power.Active.Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Factor")) then
         attribute := Power.Factor;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Offered")) then
         attribute := Power.Offered;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Reactive.Export")) then
         attribute := Power.Reactive.Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Reactive.Import")) then
         attribute := Power.Reactive.Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "SoC")) then
         attribute := SoC;
      elsif (NonSparkTypes.Uncased_Equals(str, "Voltage")) then
         attribute := Voltage;
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
         when Current.Export => str := To_Bounded_String("Current.Export");
         when Current.Import => str := To_Bounded_String("Current.Import");
         when Current.Offered => str := To_Bounded_String("Current.Offered");
         when Energy.Active.Export.Register => str := To_Bounded_String("Energy.Active.Export.Register");
         when Energy.Active.Import.Register => str := To_Bounded_String("Energy.Active.Import.Register");
         when Energy.Reactive.Export.Register => str := To_Bounded_String("Energy.Reactive.Export.Register");
         when Energy.Reactive.Import.Register => str := To_Bounded_String("Energy.Reactive.Import.Register");
         when Energy.Active.Export.Interval => str := To_Bounded_String("Energy.Active.Export.Interval");
         when Energy.Active.Import.Interval => str := To_Bounded_String("Energy.Active.Import.Interval");
         when Energy.Active.Net => str := To_Bounded_String("Energy.Active.Net");
         when Energy.Reactive.Export.Interval => str := To_Bounded_String("Energy.Reactive.Export.Interval");
         when Energy.Reactive.Import.Interval => str := To_Bounded_String("Energy.Reactive.Import.Interval");
         when Energy.Reactive.Net => str := To_Bounded_String("Energy.Reactive.Net");
         when Energy.Apparent.Net => str := To_Bounded_String("Energy.Apparent.Net");
         when Energy.Apparent.Import => str := To_Bounded_String("Energy.Apparent.Import");
         when Energy.Apparent.Export => str := To_Bounded_String("Energy.Apparent.Export");
         when Frequency => str := To_Bounded_String("Frequency");
         when Power.Active.Export => str := To_Bounded_String("Power.Active.Export");
         when Power.Active.Import => str := To_Bounded_String("Power.Active.Import");
         when Power.Factor => str := To_Bounded_String("Power.Factor");
         when Power.Offered => str := To_Bounded_String("Power.Offered");
         when Power.Reactive.Export => str := To_Bounded_String("Power.Reactive.Export");
         when Power.Reactive.Import => str := To_Bounded_String("Power.Reactive.Import");
         when SoC => str := To_Bounded_String("SoC");
         when Voltage => str := To_Bounded_String("Voltage");
      end case;
   end ToString;
end ocpp.MeasurandEnumType;
MeasurandEnumType
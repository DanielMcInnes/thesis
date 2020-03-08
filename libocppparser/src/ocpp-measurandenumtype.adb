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
         attribute := Current_Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Current.Import")) then
         attribute := Current_Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Current.Offered")) then
         attribute := Current_Offered;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Export.Register")) then
         attribute := Energy_Active_Export_Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Import.Register")) then
         attribute := Energy_Active_Import_Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Export.Register")) then
         attribute := Energy_Reactive_Export_Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Import.Register")) then
         attribute := Energy_Reactive_Import_Register;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Export.Interval")) then
         attribute := Energy_Active_Export_Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Import.Interval")) then
         attribute := Energy_Active_Import_Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Active.Net")) then
         attribute := Energy_Active_Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Export.Interval")) then
         attribute := Energy_Reactive_Export_Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Import.Interval")) then
         attribute := Energy_Reactive_Import_Interval;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Reactive.Net")) then
         attribute := Energy_Reactive_Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Net")) then
         attribute := Energy_Apparent_Net;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Import")) then
         attribute := Energy_Apparent_Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Energy.Apparent.Export")) then
         attribute := Energy_Apparent_Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Frequency")) then
         attribute := Frequency;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Active.Export")) then
         attribute := Power_Active_Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Active.Import")) then
         attribute := Power_Active_Import;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Factor")) then
         attribute := Power_Factor;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Offered")) then
         attribute := Power_Offered;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Reactive.Export")) then
         attribute := Power_Reactive_Export;
      elsif (NonSparkTypes.Uncased_Equals(str, "Power.Reactive.Import")) then
         attribute := Power_Reactive_Import;
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
         when Current_Export => str := To_Bounded_String("Current.Export");
         when Current_Import => str := To_Bounded_String("Current.Import");
         when Current_Offered => str := To_Bounded_String("Current.Offered");
         when Energy_Active_Export_Register => str := To_Bounded_String("Energy.Active.Export.Register");
         when Energy_Active_Import_Register => str := To_Bounded_String("Energy.Active.Import.Register");
         when Energy_Reactive_Export_Register => str := To_Bounded_String("Energy.Reactive.Export.Register");
         when Energy_Reactive_Import_Register => str := To_Bounded_String("Energy.Reactive.Import.Register");
         when Energy_Active_Export_Interval => str := To_Bounded_String("Energy.Active.Export.Interval");
         when Energy_Active_Import_Interval => str := To_Bounded_String("Energy.Active.Import.Interval");
         when Energy_Active_Net => str := To_Bounded_String("Energy.Active.Net");
         when Energy_Reactive_Export_Interval => str := To_Bounded_String("Energy.Reactive.Export.Interval");
         when Energy_Reactive_Import_Interval => str := To_Bounded_String("Energy.Reactive.Import.Interval");
         when Energy_Reactive_Net => str := To_Bounded_String("Energy.Reactive.Net");
         when Energy_Apparent_Net => str := To_Bounded_String("Energy.Apparent.Net");
         when Energy_Apparent_Import => str := To_Bounded_String("Energy.Apparent.Import");
         when Energy_Apparent_Export => str := To_Bounded_String("Energy.Apparent.Export");
         when Frequency => str := To_Bounded_String("Frequency");
         when Power_Active_Export => str := To_Bounded_String("Power.Active.Export");
         when Power_Active_Import => str := To_Bounded_String("Power.Active.Import");
         when Power_Factor => str := To_Bounded_String("Power.Factor");
         when Power_Offered => str := To_Bounded_String("Power.Offered");
         when Power_Reactive_Export => str := To_Bounded_String("Power.Reactive.Export");
         when Power_Reactive_Import => str := To_Bounded_String("Power.Reactive.Import");
         when SoC => str := To_Bounded_String("SoC");
         when Voltage => str := To_Bounded_String("Voltage");
      end case;
   end ToString;
end ocpp.MeasurandEnumType;

-- ocpp-ConnectorEnumType.adb

with ocpp.ConnectorEnumType; use ocpp.ConnectorEnumType;
with NonSparkTypes;

package body ocpp.ConnectorEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "cCCS1")) then
         attribute := cCCS1;
      elsif (NonSparkTypes.Uncased_Equals(str, "cCCS2")) then
         attribute := cCCS2;
      elsif (NonSparkTypes.Uncased_Equals(str, "cG105")) then
         attribute := cG105;
      elsif (NonSparkTypes.Uncased_Equals(str, "cTesla")) then
         attribute := cTesla;
      elsif (NonSparkTypes.Uncased_Equals(str, "cType1")) then
         attribute := cType1;
      elsif (NonSparkTypes.Uncased_Equals(str, "cType2")) then
         attribute := cType2;
      elsif (NonSparkTypes.Uncased_Equals(str, "s309-1P-16A")) then
         attribute := s309_1P_16A;
      elsif (NonSparkTypes.Uncased_Equals(str, "s309-1P-32A")) then
         attribute := s309_1P_32A;
      elsif (NonSparkTypes.Uncased_Equals(str, "s309-3P-16A")) then
         attribute := s309_3P_16A;
      elsif (NonSparkTypes.Uncased_Equals(str, "s309-3P-32A")) then
         attribute := s309_3P_32A;
      elsif (NonSparkTypes.Uncased_Equals(str, "sBS1361")) then
         attribute := sBS1361;
      elsif (NonSparkTypes.Uncased_Equals(str, "sCEE-7-7")) then
         attribute := sCEE_7_7;
      elsif (NonSparkTypes.Uncased_Equals(str, "sType2")) then
         attribute := sType2;
      elsif (NonSparkTypes.Uncased_Equals(str, "sType3")) then
         attribute := sType3;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other1PhMax16A")) then
         attribute := Other1PhMax16A;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other1PhOver16A")) then
         attribute := Other1PhOver16A;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other3Ph")) then
         attribute := Other3Ph;
      elsif (NonSparkTypes.Uncased_Equals(str, "Pan")) then
         attribute := Pan;
      elsif (NonSparkTypes.Uncased_Equals(str, "wInductive")) then
         attribute := wInductive;
      elsif (NonSparkTypes.Uncased_Equals(str, "wResonant")) then
         attribute := wResonant;
      elsif (NonSparkTypes.Uncased_Equals(str, "Undetermined")) then
         attribute := Undetermined;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unknown")) then
         attribute := Unknown;
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
         when cCCS1 => str := To_Bounded_String("cCCS1");
         when cCCS2 => str := To_Bounded_String("cCCS2");
         when cG105 => str := To_Bounded_String("cG105");
         when cTesla => str := To_Bounded_String("cTesla");
         when cType1 => str := To_Bounded_String("cType1");
         when cType2 => str := To_Bounded_String("cType2");
         when s309_1P_16A => str := To_Bounded_String("s309-1P-16A");
         when s309_1P_32A => str := To_Bounded_String("s309-1P-32A");
         when s309_3P_16A => str := To_Bounded_String("s309-3P-16A");
         when s309_3P_32A => str := To_Bounded_String("s309-3P-32A");
         when sBS1361 => str := To_Bounded_String("sBS1361");
         when sCEE_7_7 => str := To_Bounded_String("sCEE-7-7");
         when sType2 => str := To_Bounded_String("sType2");
         when sType3 => str := To_Bounded_String("sType3");
         when Other1PhMax16A => str := To_Bounded_String("Other1PhMax16A");
         when Other1PhOver16A => str := To_Bounded_String("Other1PhOver16A");
         when Other3Ph => str := To_Bounded_String("Other3Ph");
         when Pan => str := To_Bounded_String("Pan");
         when wInductive => str := To_Bounded_String("wInductive");
         when wResonant => str := To_Bounded_String("wResonant");
         when Undetermined => str := To_Bounded_String("Undetermined");
         when Unknown => str := To_Bounded_String("Unknown");
      end case;
   end ToString;
end ocpp.ConnectorEnumType;

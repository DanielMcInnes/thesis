-- ocpp-PhaseEnumType.adb

with ocpp.PhaseEnumType; use ocpp.PhaseEnumType;
with NonSparkTypes;

package body ocpp.PhaseEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "L1")) then
         attribute := L1;
      elsif (NonSparkTypes.Uncased_Equals(str, "L2")) then
         attribute := L2;
      elsif (NonSparkTypes.Uncased_Equals(str, "L3")) then
         attribute := L3;
      elsif (NonSparkTypes.Uncased_Equals(str, "N")) then
         attribute := N;
      elsif (NonSparkTypes.Uncased_Equals(str, "L1-N")) then
         attribute := L1-N;
      elsif (NonSparkTypes.Uncased_Equals(str, "L2-N")) then
         attribute := L2-N;
      elsif (NonSparkTypes.Uncased_Equals(str, "L3-N")) then
         attribute := L3-N;
      elsif (NonSparkTypes.Uncased_Equals(str, "L1-L2")) then
         attribute := L1-L2;
      elsif (NonSparkTypes.Uncased_Equals(str, "L2-L3")) then
         attribute := L2-L3;
      elsif (NonSparkTypes.Uncased_Equals(str, "L3-L1")) then
         attribute := L3-L1;
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
         when L1 => str := To_Bounded_String("L1");
         when L2 => str := To_Bounded_String("L2");
         when L3 => str := To_Bounded_String("L3");
         when N => str := To_Bounded_String("N");
         when L1-N => str := To_Bounded_String("L1-N");
         when L2-N => str := To_Bounded_String("L2-N");
         when L3-N => str := To_Bounded_String("L3-N");
         when L1-L2 => str := To_Bounded_String("L1-L2");
         when L2-L3 => str := To_Bounded_String("L2-L3");
         when L3-L1 => str := To_Bounded_String("L3-L1");
      end case;
   end ToString;
end ocpp.PhaseEnumType;
PhaseEnumType
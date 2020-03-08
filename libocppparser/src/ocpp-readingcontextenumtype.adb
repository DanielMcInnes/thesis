-- ocpp-ReadingContextEnumType.adb

with ocpp.ReadingContextEnumType; use ocpp.ReadingContextEnumType;
with NonSparkTypes;

package body ocpp.ReadingContextEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Interruption.Begin")) then
         attribute := Interruption_Begin;
      elsif (NonSparkTypes.Uncased_Equals(str, "Interruption.End")) then
         attribute := Interruption_End;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other")) then
         attribute := Other;
      elsif (NonSparkTypes.Uncased_Equals(str, "Sample.Clock")) then
         attribute := Sample_Clock;
      elsif (NonSparkTypes.Uncased_Equals(str, "Sample.Periodic")) then
         attribute := Sample_Periodic;
      elsif (NonSparkTypes.Uncased_Equals(str, "Transaction.Begin")) then
         attribute := Transaction_Begin;
      elsif (NonSparkTypes.Uncased_Equals(str, "Transaction.End")) then
         attribute := Transaction_End;
      elsif (NonSparkTypes.Uncased_Equals(str, "Trigger")) then
         attribute := Trigger;
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
         when Interruption_Begin => str := To_Bounded_String("Interruption.Begin");
         when Interruption_End => str := To_Bounded_String("Interruption.End");
         when Other => str := To_Bounded_String("Other");
         when Sample_Clock => str := To_Bounded_String("Sample.Clock");
         when Sample_Periodic => str := To_Bounded_String("Sample.Periodic");
         when Transaction_Begin => str := To_Bounded_String("Transaction.Begin");
         when Transaction_End => str := To_Bounded_String("Transaction.End");
         when Trigger => str := To_Bounded_String("Trigger");
      end case;
   end ToString;
end ocpp.ReadingContextEnumType;

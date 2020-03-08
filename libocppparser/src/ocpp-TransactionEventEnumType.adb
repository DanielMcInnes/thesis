-- ocpp-TransactionEventEnumType.adb

with ocpp.TransactionEventEnumType; use ocpp.TransactionEventEnumType;
with NonSparkTypes;

package body ocpp.TransactionEventEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Ended")) then
         attribute := Ended;
      elsif (NonSparkTypes.Uncased_Equals(str, "Started")) then
         attribute := Started;
      elsif (NonSparkTypes.Uncased_Equals(str, "Updated")) then
         attribute := Updated;
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
         when Ended => str := To_Bounded_String("Ended");
         when Started => str := To_Bounded_String("Started");
         when Updated => str := To_Bounded_String("Updated");
      end case;
   end ToString;
end ocpp.TransactionEventEnumType;
TransactionEventEnumType
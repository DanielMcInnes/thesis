-- ocpp-UnlockStatusEnumType.adb

with ocpp.UnlockStatusEnumType; use ocpp.UnlockStatusEnumType;
with NonSparkTypes;

package body ocpp.UnlockStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Unlocked")) then
         attribute := Unlocked;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnlockFailed")) then
         attribute := UnlockFailed;
      elsif (NonSparkTypes.Uncased_Equals(str, "OngoingAuthorizedTransaction")) then
         attribute := OngoingAuthorizedTransaction;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownConnector")) then
         attribute := UnknownConnector;
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
         when Unlocked => str := To_Bounded_String("Unlocked");
         when UnlockFailed => str := To_Bounded_String("UnlockFailed");
         when OngoingAuthorizedTransaction => str := To_Bounded_String("OngoingAuthorizedTransaction");
         when UnknownConnector => str := To_Bounded_String("UnknownConnector");
      end case;
   end ToString;
end ocpp.UnlockStatusEnumType;

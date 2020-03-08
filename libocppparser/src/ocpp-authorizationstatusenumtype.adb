-- ocpp-AuthorizationStatusEnumType.adb

with ocpp.AuthorizationStatusEnumType; use ocpp.AuthorizationStatusEnumType;
with NonSparkTypes;

package body ocpp.AuthorizationStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Blocked")) then
         attribute := Blocked;
      elsif (NonSparkTypes.Uncased_Equals(str, "ConcurrentTx")) then
         attribute := ConcurrentTx;
      elsif (NonSparkTypes.Uncased_Equals(str, "Expired")) then
         attribute := Expired;
      elsif (NonSparkTypes.Uncased_Equals(str, "Invalid")) then
         attribute := Invalid;
      elsif (NonSparkTypes.Uncased_Equals(str, "NoCredit")) then
         attribute := NoCredit;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotAllowedTypeEVSE")) then
         attribute := NotAllowedTypeEVSE;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotAtThisLocation")) then
         attribute := NotAtThisLocation;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotAtThisTime")) then
         attribute := NotAtThisTime;
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
         when Accepted => str := To_Bounded_String("Accepted");
         when Blocked => str := To_Bounded_String("Blocked");
         when ConcurrentTx => str := To_Bounded_String("ConcurrentTx");
         when Expired => str := To_Bounded_String("Expired");
         when Invalid => str := To_Bounded_String("Invalid");
         when NoCredit => str := To_Bounded_String("NoCredit");
         when NotAllowedTypeEVSE => str := To_Bounded_String("NotAllowedTypeEVSE");
         when NotAtThisLocation => str := To_Bounded_String("NotAtThisLocation");
         when NotAtThisTime => str := To_Bounded_String("NotAtThisTime");
         when Unknown => str := To_Bounded_String("Unknown");
      end case;
   end ToString;
end ocpp.AuthorizationStatusEnumType;

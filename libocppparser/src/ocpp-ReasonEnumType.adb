-- ocpp-ReasonEnumType.adb

with ocpp.ReasonEnumType; use ocpp.ReasonEnumType;
with NonSparkTypes;

package body ocpp.ReasonEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "DeAuthorized")) then
         attribute := DeAuthorized;
      elsif (NonSparkTypes.Uncased_Equals(str, "EmergencyStop")) then
         attribute := EmergencyStop;
      elsif (NonSparkTypes.Uncased_Equals(str, "EnergyLimitReached")) then
         attribute := EnergyLimitReached;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVDisconnected")) then
         attribute := EVDisconnected;
      elsif (NonSparkTypes.Uncased_Equals(str, "GroundFault")) then
         attribute := GroundFault;
      elsif (NonSparkTypes.Uncased_Equals(str, "ImmediateReset")) then
         attribute := ImmediateReset;
      elsif (NonSparkTypes.Uncased_Equals(str, "Local")) then
         attribute := Local;
      elsif (NonSparkTypes.Uncased_Equals(str, "LocalOutOfCredit")) then
         attribute := LocalOutOfCredit;
      elsif (NonSparkTypes.Uncased_Equals(str, "MasterPass")) then
         attribute := MasterPass;
      elsif (NonSparkTypes.Uncased_Equals(str, "Other")) then
         attribute := Other;
      elsif (NonSparkTypes.Uncased_Equals(str, "OvercurrentFault")) then
         attribute := OvercurrentFault;
      elsif (NonSparkTypes.Uncased_Equals(str, "PowerLoss")) then
         attribute := PowerLoss;
      elsif (NonSparkTypes.Uncased_Equals(str, "PowerQuality")) then
         attribute := PowerQuality;
      elsif (NonSparkTypes.Uncased_Equals(str, "Reboot")) then
         attribute := Reboot;
      elsif (NonSparkTypes.Uncased_Equals(str, "Remote")) then
         attribute := Remote;
      elsif (NonSparkTypes.Uncased_Equals(str, "SOCLimitReached")) then
         attribute := SOCLimitReached;
      elsif (NonSparkTypes.Uncased_Equals(str, "StoppedByEV")) then
         attribute := StoppedByEV;
      elsif (NonSparkTypes.Uncased_Equals(str, "TimeLimitReached")) then
         attribute := TimeLimitReached;
      elsif (NonSparkTypes.Uncased_Equals(str, "Timeout")) then
         attribute := Timeout;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnlockCommand")) then
         attribute := UnlockCommand;
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
         when DeAuthorized => str := To_Bounded_String("DeAuthorized");
         when EmergencyStop => str := To_Bounded_String("EmergencyStop");
         when EnergyLimitReached => str := To_Bounded_String("EnergyLimitReached");
         when EVDisconnected => str := To_Bounded_String("EVDisconnected");
         when GroundFault => str := To_Bounded_String("GroundFault");
         when ImmediateReset => str := To_Bounded_String("ImmediateReset");
         when Local => str := To_Bounded_String("Local");
         when LocalOutOfCredit => str := To_Bounded_String("LocalOutOfCredit");
         when MasterPass => str := To_Bounded_String("MasterPass");
         when Other => str := To_Bounded_String("Other");
         when OvercurrentFault => str := To_Bounded_String("OvercurrentFault");
         when PowerLoss => str := To_Bounded_String("PowerLoss");
         when PowerQuality => str := To_Bounded_String("PowerQuality");
         when Reboot => str := To_Bounded_String("Reboot");
         when Remote => str := To_Bounded_String("Remote");
         when SOCLimitReached => str := To_Bounded_String("SOCLimitReached");
         when StoppedByEV => str := To_Bounded_String("StoppedByEV");
         when TimeLimitReached => str := To_Bounded_String("TimeLimitReached");
         when Timeout => str := To_Bounded_String("Timeout");
         when UnlockCommand => str := To_Bounded_String("UnlockCommand");
      end case;
   end ToString;
end ocpp.ReasonEnumType;
ReasonEnumType
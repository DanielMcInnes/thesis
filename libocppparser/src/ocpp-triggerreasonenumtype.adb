with ocpp.ResetEnumType; use ocpp.ResetEnumType;
with NonSparkTypes;

package body ocpp.TriggerReasonEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin      
      if (NonSparkTypes.Uncased_Equals(str, "Invalid")) then
         attribute := Invalid;
      elsif (NonSparkTypes.Uncased_Equals(str, "Authorized")) then
         attribute := Authorized;
      elsif (NonSparkTypes.Uncased_Equals(str, "CablePluggedIn")) then
         attribute := CablePluggedIn;
      elsif (NonSparkTypes.Uncased_Equals(str, "ChargingRateChanged")) then
         attribute := ChargingRateChanged;
      elsif (NonSparkTypes.Uncased_Equals(str, "ChargingStateChanged")) then
         attribute := ChargingStateChanged;
      elsif (NonSparkTypes.Uncased_Equals(str, "Deauthorized")) then
         attribute := Deauthorized;
      elsif (NonSparkTypes.Uncased_Equals(str, "EnergyLimitReached")) then
         attribute := EnergyLimitReached;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVCommunicationLost")) then
         attribute := EVCommunicationLost;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVConnectTimeout")) then
         attribute := EVConnectTimeout;
      elsif (NonSparkTypes.Uncased_Equals(str, "MeterValueClock")) then
         attribute := MeterValueClock;
      elsif (NonSparkTypes.Uncased_Equals(str, "MeterValuePeriodic")) then
         attribute := MeterValuePeriodic;
      elsif (NonSparkTypes.Uncased_Equals(str, "TimeLimitReached")) then
         attribute := TimeLimitReached;
      elsif (NonSparkTypes.Uncased_Equals(str, "Trigger")) then
         attribute := Trigger;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnlockCommand")) then
         attribute := UnlockCommand;
      elsif (NonSparkTypes.Uncased_Equals(str, "StopAuthorized")) then
         attribute := StopAuthorized;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVDeparted")) then
         attribute := EVDeparted;
      elsif (NonSparkTypes.Uncased_Equals(str, "EVDetected")) then
         attribute := EVDetected;
      elsif (NonSparkTypes.Uncased_Equals(str, "RemoteStop")) then
         attribute := RemoteStop;
      elsif (NonSparkTypes.Uncased_Equals(str, "RemoteStart")) then
         attribute := RemoteStart;
      else
         attribute := Invalid;
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
         when Invalid => str := To_Bounded_String("Invalid");
         when Authorized => str := To_Bounded_String("Authorized");
         when CablePluggedIn => str := To_Bounded_String("CablePluggedIn");
         when ChargingRateChanged => str := To_Bounded_String("ChargingRateChanged");
         when ChargingStateChanged => str := To_Bounded_String("ChargingStateChanged");
         when Deauthorized => str := To_Bounded_String("Deauthorized");
         when EnergyLimitReached => str := To_Bounded_String("EnergyLimitReached");
         when EVCommunicationLost => str := To_Bounded_String("EVCommunicationLost");
         when EVConnectTimeout => str := To_Bounded_String("EVConnectTimeout");
         when MeterValueClock => str := To_Bounded_String("MeterValueClock");
         when MeterValuePeriodic => str := To_Bounded_String("MeterValuePeriodic");
         when TimeLimitReached => str := To_Bounded_String("TimeLimitReached");
         when Trigger => str := To_Bounded_String("Trigger");
         when UnlockCommand => str := To_Bounded_String("UnlockCommand");
         when StopAuthorized => str := To_Bounded_String("StopAuthorized");
         when EVDeparted => str := To_Bounded_String("EVDeparted");
         when EVDetected => str := To_Bounded_String("EVDetected");
         when RemoteStop => str := To_Bounded_String("RemoteStop");
         when RemoteStart => str := To_Bounded_String("RemoteStart");
      end case;

   end ToString;

end ocpp.TriggerReasonEnumType;

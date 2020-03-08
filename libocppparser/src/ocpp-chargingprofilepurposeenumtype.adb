-- ocpp-ChargingProfilePurposeEnumType.adb

with ocpp.ChargingProfilePurposeEnumType; use ocpp.ChargingProfilePurposeEnumType;
with NonSparkTypes;

package body ocpp.ChargingProfilePurposeEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "ChargingStationExternalConstraints")) then
         attribute := ChargingStationExternalConstraints;
      elsif (NonSparkTypes.Uncased_Equals(str, "ChargingStationMaxProfile")) then
         attribute := ChargingStationMaxProfile;
      elsif (NonSparkTypes.Uncased_Equals(str, "TxDefaultProfile")) then
         attribute := TxDefaultProfile;
      elsif (NonSparkTypes.Uncased_Equals(str, "TxProfile")) then
         attribute := TxProfile;
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
         when ChargingStationExternalConstraints => str := To_Bounded_String("ChargingStationExternalConstraints");
         when ChargingStationMaxProfile => str := To_Bounded_String("ChargingStationMaxProfile");
         when TxDefaultProfile => str := To_Bounded_String("TxDefaultProfile");
         when TxProfile => str := To_Bounded_String("TxProfile");
      end case;
   end ToString;
end ocpp.ChargingProfilePurposeEnumType;

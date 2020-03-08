-- ocpp-MessageTriggerEnumType.adb

with ocpp.MessageTriggerEnumType; use ocpp.MessageTriggerEnumType;
with NonSparkTypes;

package body ocpp.MessageTriggerEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "BootNotification")) then
         attribute := BootNotification;
      elsif (NonSparkTypes.Uncased_Equals(str, "LogStatusNotification")) then
         attribute := LogStatusNotification;
      elsif (NonSparkTypes.Uncased_Equals(str, "FirmwareStatusNotification")) then
         attribute := FirmwareStatusNotification;
      elsif (NonSparkTypes.Uncased_Equals(str, "Heartbeat")) then
         attribute := Heartbeat;
      elsif (NonSparkTypes.Uncased_Equals(str, "MeterValues")) then
         attribute := MeterValues;
      elsif (NonSparkTypes.Uncased_Equals(str, "SignChargingStationCertificate")) then
         attribute := SignChargingStationCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "SignV2GCertificate")) then
         attribute := SignV2GCertificate;
      elsif (NonSparkTypes.Uncased_Equals(str, "StatusNotification")) then
         attribute := StatusNotification;
      elsif (NonSparkTypes.Uncased_Equals(str, "TransactionEvent")) then
         attribute := TransactionEvent;
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
         when BootNotification => str := To_Bounded_String("BootNotification");
         when LogStatusNotification => str := To_Bounded_String("LogStatusNotification");
         when FirmwareStatusNotification => str := To_Bounded_String("FirmwareStatusNotification");
         when Heartbeat => str := To_Bounded_String("Heartbeat");
         when MeterValues => str := To_Bounded_String("MeterValues");
         when SignChargingStationCertificate => str := To_Bounded_String("SignChargingStationCertificate");
         when SignV2GCertificate => str := To_Bounded_String("SignV2GCertificate");
         when StatusNotification => str := To_Bounded_String("StatusNotification");
         when TransactionEvent => str := To_Bounded_String("TransactionEvent");
      end case;
   end ToString;
end ocpp.MessageTriggerEnumType;

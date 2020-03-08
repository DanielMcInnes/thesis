-- start ocppMessageTriggerEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MessageTriggerEnumType is
   type T is (
      BootNotification,
      LogStatusNotification,
      FirmwareStatusNotification,
      Heartbeat,
      MeterValues,
      SignChargingStationCertificate,
      SignV2GCertificate,
      StatusNotification,
      TransactionEvent
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 30);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MessageTriggerEnumType;
-- end ocpp-MessageTriggerEnumType.ads

-- start ocppPublishFirmwareStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.PublishFirmwareStatusEnumType is
   type T is (
      Downloaded,
      DownloadFailed,
      Downloading,
      DownloadScheduled,
      DownloadPaused,
      PublishFailed,
      Published,
      InvalidChecksum,
      ChecksumVerified
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 17);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.PublishFirmwareStatusEnumType;
-- end ocpp-PublishFirmwareStatusEnumType.ads

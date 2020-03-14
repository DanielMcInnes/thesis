-- start ocppFirmwareStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.FirmwareStatusEnumType is
   type T is (
      Downloaded,
      DownloadFailed,
      Downloading,
      DownloadScheduled,
      DownloadPaused,
      Idle,
      InstallationFailed,
      Installing,
      Installed,
      InstallRebooting,
      InstallScheduled,
      InstallVerificationFailed,
      InvalidSignature,
      SignatureVerified
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 25);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.FirmwareStatusEnumType;
-- end ocpp-FirmwareStatusEnumType.ads

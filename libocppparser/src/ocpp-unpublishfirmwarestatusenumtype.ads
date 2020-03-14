-- start ocppUnpublishFirmwareStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.UnpublishFirmwareStatusEnumType is
   type T is (
      DownloadOngoing,
      NoFirmware,
      Unpublished
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.UnpublishFirmwareStatusEnumType;
-- end ocpp-UnpublishFirmwareStatusEnumType.ads

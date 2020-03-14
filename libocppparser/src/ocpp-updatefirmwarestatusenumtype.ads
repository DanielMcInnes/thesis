-- start ocppUpdateFirmwareStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.UpdateFirmwareStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      AcceptedCanceled,
      InvalidCertificate,
      RevokedCertificate
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 18);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.UpdateFirmwareStatusEnumType;
-- end ocpp-UpdateFirmwareStatusEnumType.ads

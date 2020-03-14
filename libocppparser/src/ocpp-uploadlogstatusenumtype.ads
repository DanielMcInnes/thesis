-- start ocppUploadLogStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.UploadLogStatusEnumType is
   type T is (
      BadMessage,
      Idle,
      NotSupportedOperation,
      PermissionDenied,
      Uploaded,
      UploadFailure,
      Uploading
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 21);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.UploadLogStatusEnumType;
-- end ocpp-UploadLogStatusEnumType.ads

-- start ocppUpdateStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.UpdateStatusEnumType is
   type T is (
      Accepted,
      Failed,
      VersionMismatch
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.UpdateStatusEnumType;
-- end ocpp-UpdateStatusEnumType.ads

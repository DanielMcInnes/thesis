-- start ocppAPNAuthenticationEnumType.ads
with Ada.Strings.Bounded;

package ocpp.APNAuthenticationEnumType is
   type T is (
      CHAP,
      NONE,
      PAP,
      AUTO
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 4);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.APNAuthenticationEnumType;
-- end ocpp-APNAuthenticationEnumType.ads

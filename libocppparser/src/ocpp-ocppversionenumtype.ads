-- start ocppOCPPVersionEnumType.ads
with Ada.Strings.Bounded;

package ocpp.OCPPVersionEnumType is
   type T is (
      OCPP12,
      OCPP15,
      OCPP16,
      OCPP20
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 6);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.OCPPVersionEnumType;
-- end ocpp-OCPPVersionEnumType.ads

-- start ocppOCPPInterfaceEnumType.ads
with Ada.Strings.Bounded;

package ocpp.OCPPInterfaceEnumType is
   type T is (
      Wired0,
      Wired1,
      Wired2,
      Wired3,
      Wireless0,
      Wireless1,
      Wireless2,
      Wireless3
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.OCPPInterfaceEnumType;
-- end ocpp-OCPPInterfaceEnumType.ads

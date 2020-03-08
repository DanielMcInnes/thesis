-- start ocppVPNEnumType.ads
with Ada.Strings.Bounded;

package ocpp.VPNEnumType is
   type T is (
      IKEv2,
      IPSec,
      L2TP,
      PPTP
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.VPNEnumType;
-- end ocpp-VPNEnumType.ads

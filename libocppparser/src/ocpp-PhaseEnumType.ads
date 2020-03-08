-- start ocppPhaseEnumType.ads
with Ada.Strings.Bounded;

package ocpp.PhaseEnumType is
   type T is (
      L1,
      L2,
      L3,
      N,
      L1-N,
      L2-N,
      L3-N,
      L1-L2,
      L2-L3,
      L3-L1
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.PhaseEnumType;
-- end ocpp-PhaseEnumType.ads

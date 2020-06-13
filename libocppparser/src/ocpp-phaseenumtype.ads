-- start ocppPhaseEnumType.ads
with Ada.Strings.Bounded;

package ocpp.PhaseEnumType is
   type T is (
      L1,
      L2,
      L3,
      N,
      L1_N,
      L2_N,
      L3_N,
      L1_L2,
      L2_L3,
      L3_L1
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.PhaseEnumType;
-- end ocpp-PhaseEnumType.ads

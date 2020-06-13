-- start ocppLocationEnumType.ads
with Ada.Strings.Bounded;

package ocpp.LocationEnumType is
   type T is (
      ABody,
      Cable,
      EV,
      Inlet,
      Outlet
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 6);
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
end ocpp.LocationEnumType;
-- end ocpp-LocationEnumType.ads

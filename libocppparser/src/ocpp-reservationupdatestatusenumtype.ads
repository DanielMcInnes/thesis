-- start ocppReservationUpdateStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ReservationUpdateStatusEnumType is
   type T is (
      Expired,
      Removed
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 7);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ReservationUpdateStatusEnumType;
-- end ocpp-ReservationUpdateStatusEnumType.ads

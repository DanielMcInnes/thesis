-- start ocppReserveNowStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ReserveNowStatusEnumType is
   type T is (
      Accepted,
      Faulted,
      Occupied,
      Rejected,
      Unavailable
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 11);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ReserveNowStatusEnumType;
-- end ocpp-ReserveNowStatusEnumType.ads

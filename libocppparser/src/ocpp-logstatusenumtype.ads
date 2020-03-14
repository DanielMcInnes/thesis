-- start ocppLogStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.LogStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      AcceptedCanceled
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 16);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.LogStatusEnumType;
-- end ocpp-LogStatusEnumType.ads

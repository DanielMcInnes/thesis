-- start ocppRecurrencyKindEnumType.ads
with Ada.Strings.Bounded;

package ocpp.RecurrencyKindEnumType is
   type T is (
      Daily,
      Weekly
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 6);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.RecurrencyKindEnumType;
-- end ocpp-RecurrencyKindEnumType.ads

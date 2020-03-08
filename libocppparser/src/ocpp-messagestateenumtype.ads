-- start ocppMessageStateEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MessageStateEnumType is
   type T is (
      Charging,
      Faulted,
      Idle,
      Unavailable
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 11);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MessageStateEnumType;
-- end ocpp-MessageStateEnumType.ads

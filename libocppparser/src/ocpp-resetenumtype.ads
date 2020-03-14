-- start ocppResetEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ResetEnumType is
   type T is (
      Immediate,
      OnIdle
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ResetEnumType;
-- end ocpp-ResetEnumType.ads

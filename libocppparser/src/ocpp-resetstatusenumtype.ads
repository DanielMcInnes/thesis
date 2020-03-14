-- start ocppResetStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ResetStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      Scheduled
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ResetStatusEnumType;
-- end ocpp-ResetStatusEnumType.ads
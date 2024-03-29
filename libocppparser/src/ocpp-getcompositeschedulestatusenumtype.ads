-- start ocppGetCompositeScheduleStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.GetCompositeScheduleStatusEnumType is
   type T is (
      Accepted,
      Rejected
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.GetCompositeScheduleStatusEnumType;
-- end ocpp-GetCompositeScheduleStatusEnumType.ads

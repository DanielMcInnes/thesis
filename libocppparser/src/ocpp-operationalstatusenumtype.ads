-- start ocppOperationalStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.OperationalStatusEnumType is
   type T is (
      Inoperative,
      Operative
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 11);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.OperationalStatusEnumType;
-- end ocpp-OperationalStatusEnumType.ads

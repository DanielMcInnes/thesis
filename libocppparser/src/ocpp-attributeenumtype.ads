-- start ocppAttributeEnumType.ads
with Ada.Strings.Bounded;

package ocpp.AttributeEnumType is
   type T is (
      Actual,
      Target,
      MinSet,
      MaxSet
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 6);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.AttributeEnumType;
-- end ocpp-AttributeEnumType.ads

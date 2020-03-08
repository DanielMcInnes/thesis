-- start ocppGetVariableStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.GetVariableStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      UnknownComponent,
      UnknownVariable,
      NotSupportedAttributeType
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 25);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.GetVariableStatusEnumType;
-- end ocpp-GetVariableStatusEnumType.ads

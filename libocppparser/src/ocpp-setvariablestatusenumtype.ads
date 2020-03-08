-- start ocppSetVariableStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.SetVariableStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      InvalidValue,
      UnknownComponent,
      UnknownVariable,
      NotSupportedAttributeType,
      OutOfRange,
      RebootRequired
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 25);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.SetVariableStatusEnumType;
-- end ocpp-SetVariableStatusEnumType.ads

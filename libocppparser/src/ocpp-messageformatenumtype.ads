-- start ocppMessageFormatEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MessageFormatEnumType is
   type T is (
      ASCII,
      HTML,
      URI,
      UTF8
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.MessageFormatEnumType;
-- end ocpp-MessageFormatEnumType.ads

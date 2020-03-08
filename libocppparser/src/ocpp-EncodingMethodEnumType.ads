-- start ocppEncodingMethodEnumType.ads
with Ada.Strings.Bounded;

package ocpp.EncodingMethodEnumType is
   type T is (
      Other,
      DLMS Message,
      COSEM Protected Data,
      EDL
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.EncodingMethodEnumType;
-- end ocpp-EncodingMethodEnumType.ads

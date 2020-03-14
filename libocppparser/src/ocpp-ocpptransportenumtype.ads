-- start ocppOCPPTransportEnumType.ads
with Ada.Strings.Bounded;

package ocpp.OCPPTransportEnumType is
   type T is (
      JSON,
      SOAP
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 4);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.OCPPTransportEnumType;
-- end ocpp-OCPPTransportEnumType.ads
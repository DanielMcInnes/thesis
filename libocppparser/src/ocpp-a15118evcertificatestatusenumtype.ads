-- start ocpp15118EVCertificateStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.a15118EVCertificateStatusEnumType is
   type T is (
      Accepted,
      Failed
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.a15118EVCertificateStatusEnumType;
-- end ocpp-a15118EVCertificateStatusEnumType.ads

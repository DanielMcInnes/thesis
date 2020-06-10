-- start ocppIdTokenEnumType.ads
with Ada.Strings.Bounded;

package ocpp.IdTokenEnumType is
   type T is (
      Central,
      eMAID,
      ISO14443,
      KeyCode,
      Local,
      NoAuthorization,
      ISO15693
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
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
end ocpp.IdTokenEnumType;
-- end ocpp-IdTokenEnumType.ads

-- start ocppAuthorizationStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.AuthorizationStatusEnumType is
   type T is (
      Accepted,
      Blocked,
      ConcurrentTx,
      Expired,
      Invalid,
      NoCredit,
      NotAllowedTypeEVSE,
      NotAtThisLocation,
      NotAtThisTime,
      Unknown
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 18);
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
end ocpp.AuthorizationStatusEnumType;
-- end ocpp-AuthorizationStatusEnumType.ads

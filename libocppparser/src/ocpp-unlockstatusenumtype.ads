-- start ocppUnlockStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.UnlockStatusEnumType is
   type T is (
      Unlocked,
      UnlockFailed,
      OngoingAuthorizedTransaction,
      UnknownConnector
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 28);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.UnlockStatusEnumType;
-- end ocpp-UnlockStatusEnumType.ads

-- start ocppNotifyEVChargingNeedsStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.NotifyEVChargingNeedsStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      Processing
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 10);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.NotifyEVChargingNeedsStatusEnumType;
-- end ocpp-NotifyEVChargingNeedsStatusEnumType.ads

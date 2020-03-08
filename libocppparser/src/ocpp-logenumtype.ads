-- start ocppLogEnumType.ads
with Ada.Strings.Bounded;

package ocpp.LogEnumType is
   type T is (
      DiagnosticsLog,
      SecurityLog
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 14);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.LogEnumType;
-- end ocpp-LogEnumType.ads

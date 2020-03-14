-- start ocppConnectorStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ConnectorStatusEnumType is
   type T is (
      Available,
      Occupied,
      Reserved,
      Unavailable,
      Faulted
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 11);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ConnectorStatusEnumType;
-- end ocpp-ConnectorStatusEnumType.ads
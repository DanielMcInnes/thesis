-- start ocppGenericDeviceModelStatusEnumType.ads
with Ada.Strings.Bounded;

package ocpp.GenericDeviceModelStatusEnumType is
   type T is (
      Accepted,
      Rejected,
      NotSupported,
      EmptyResultSet
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 14);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.GenericDeviceModelStatusEnumType;
-- end ocpp-GenericDeviceModelStatusEnumType.ads

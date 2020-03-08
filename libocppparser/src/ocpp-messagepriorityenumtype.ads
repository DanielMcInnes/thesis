-- start ocppMessagePriorityEnumType.ads
with Ada.Strings.Bounded;

package ocpp.MessagePriorityEnumType is
   type T is (
      AlwaysFront,
      InFront,
      NormalCycle
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 11);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.MessagePriorityEnumType;
-- end ocpp-MessagePriorityEnumType.ads

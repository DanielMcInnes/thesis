-- start ocppDataEnumType.ads
with Ada.Strings.Bounded;

package ocpp.DataEnumType is
   type T is (
      zzzstring,
      decimal,
      integer,
      dateTime,
      zzzboolean,
      OptionList,
      SequenceList,
      MemberList
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 12);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.DataEnumType;
-- end ocpp-DataEnumType.ads

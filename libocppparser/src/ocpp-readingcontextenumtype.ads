-- start ocppReadingContextEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ReadingContextEnumType is
   type T is (
      Interruption_Begin,
      Interruption_End,
      Other,
      Sample_Clock,
      Sample_Periodic,
      Transaction_Begin,
      Transaction_End,
      Trigger
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 18);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ReadingContextEnumType;
-- end ocpp-ReadingContextEnumType.ads

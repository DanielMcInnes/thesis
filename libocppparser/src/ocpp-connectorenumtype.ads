-- start ocppConnectorEnumType.ads
with Ada.Strings.Bounded;

package ocpp.ConnectorEnumType is
   type T is (
      cCCS1,
      cCCS2,
      cG105,
      cTesla,
      cType1,
      cType2,
      s309_1P_16A,
      s309_1P_32A,
      s309_3P_16A,
      s309_3P_32A,
      sBS1361,
      sCEE_7_7,
      sType2,
      sType3,
      Other1PhMax16A,
      Other1PhOver16A,
      Other3Ph,
      Pan,
      wInductive,
      wResonant,
      Undetermined,
      Unknown
   );

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 15);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);
   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);
end ocpp.ConnectorEnumType;
-- end ocpp-ConnectorEnumType.ads

-- ocpp-VPNEnumType.adb

with ocpp.VPNEnumType; use ocpp.VPNEnumType;
with NonSparkTypes;

package body ocpp.VPNEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "IKEv2")) then
         attribute := IKEv2;
      elsif (NonSparkTypes.Uncased_Equals(str, "IPSec")) then
         attribute := IPSec;
      elsif (NonSparkTypes.Uncased_Equals(str, "L2TP")) then
         attribute := L2TP;
      elsif (NonSparkTypes.Uncased_Equals(str, "PPTP")) then
         attribute := PPTP;
      else
         valid := false;
         return;
      end if;
      valid := true;
   end FromString;

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String)
   is
      use string_t;
   begin
      case attribute is
         when IKEv2 => str := To_Bounded_String("IKEv2");
         when IPSec => str := To_Bounded_String("IPSec");
         when L2TP => str := To_Bounded_String("L2TP");
         when PPTP => str := To_Bounded_String("PPTP");
      end case;
   end ToString;
end ocpp.VPNEnumType;

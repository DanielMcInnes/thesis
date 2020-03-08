-- ocpp-APNAuthenticationEnumType.adb

with ocpp.APNAuthenticationEnumType; use ocpp.APNAuthenticationEnumType;
with NonSparkTypes;

package body ocpp.APNAuthenticationEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "CHAP")) then
         attribute := CHAP;
      elsif (NonSparkTypes.Uncased_Equals(str, "NONE")) then
         attribute := NONE;
      elsif (NonSparkTypes.Uncased_Equals(str, "PAP")) then
         attribute := PAP;
      elsif (NonSparkTypes.Uncased_Equals(str, "AUTO")) then
         attribute := AUTO;
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
         when CHAP => str := To_Bounded_String("CHAP");
         when NONE => str := To_Bounded_String("NONE");
         when PAP => str := To_Bounded_String("PAP");
         when AUTO => str := To_Bounded_String("AUTO");
      end case;
   end ToString;
end ocpp.APNAuthenticationEnumType;

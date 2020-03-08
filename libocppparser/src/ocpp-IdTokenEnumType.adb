-- ocpp-IdTokenEnumType.adb

with ocpp.IdTokenEnumType; use ocpp.IdTokenEnumType;
with NonSparkTypes;

package body ocpp.IdTokenEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Central")) then
         attribute := Central;
      elsif (NonSparkTypes.Uncased_Equals(str, "eMAID")) then
         attribute := eMAID;
      elsif (NonSparkTypes.Uncased_Equals(str, "ISO14443")) then
         attribute := ISO14443;
      elsif (NonSparkTypes.Uncased_Equals(str, "KeyCode")) then
         attribute := KeyCode;
      elsif (NonSparkTypes.Uncased_Equals(str, "Local")) then
         attribute := Local;
      elsif (NonSparkTypes.Uncased_Equals(str, "NoAuthorization")) then
         attribute := NoAuthorization;
      elsif (NonSparkTypes.Uncased_Equals(str, "ISO15693")) then
         attribute := ISO15693;
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
         when Central => str := To_Bounded_String("Central");
         when eMAID => str := To_Bounded_String("eMAID");
         when ISO14443 => str := To_Bounded_String("ISO14443");
         when KeyCode => str := To_Bounded_String("KeyCode");
         when Local => str := To_Bounded_String("Local");
         when NoAuthorization => str := To_Bounded_String("NoAuthorization");
         when ISO15693 => str := To_Bounded_String("ISO15693");
      end case;
   end ToString;
end ocpp.IdTokenEnumType;
IdTokenEnumType
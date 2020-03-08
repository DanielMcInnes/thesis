-- ocpp-EncodingMethodEnumType.adb

with ocpp.EncodingMethodEnumType; use ocpp.EncodingMethodEnumType;
with NonSparkTypes;

package body ocpp.EncodingMethodEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Other")) then
         attribute := Other;
      elsif (NonSparkTypes.Uncased_Equals(str, "DLMS Message")) then
         attribute := DLMS_Message;
      elsif (NonSparkTypes.Uncased_Equals(str, "COSEM Protected Data")) then
         attribute := COSEM_Protected_Data;
      elsif (NonSparkTypes.Uncased_Equals(str, "EDL")) then
         attribute := EDL;
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
         when Other => str := To_Bounded_String("Other");
         when DLMS_Message => str := To_Bounded_String("DLMS Message");
         when COSEM_Protected_Data => str := To_Bounded_String("COSEM Protected Data");
         when EDL => str := To_Bounded_String("EDL");
      end case;
   end ToString;
end ocpp.EncodingMethodEnumType;

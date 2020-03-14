-- ocpp-DataTransferStatusEnumType.adb

with ocpp.DataTransferStatusEnumType; use ocpp.DataTransferStatusEnumType;
with NonSparkTypes;

package body ocpp.DataTransferStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Accepted")) then
         attribute := Accepted;
      elsif (NonSparkTypes.Uncased_Equals(str, "Rejected")) then
         attribute := Rejected;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownMessageId")) then
         attribute := UnknownMessageId;
      elsif (NonSparkTypes.Uncased_Equals(str, "UnknownVendorId")) then
         attribute := UnknownVendorId;
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
         when Accepted => str := To_Bounded_String("Accepted");
         when Rejected => str := To_Bounded_String("Rejected");
         when UnknownMessageId => str := To_Bounded_String("UnknownMessageId");
         when UnknownVendorId => str := To_Bounded_String("UnknownVendorId");
      end case;
   end ToString;
end ocpp.DataTransferStatusEnumType;

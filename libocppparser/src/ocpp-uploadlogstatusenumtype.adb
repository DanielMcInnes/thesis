-- ocpp-UploadLogStatusEnumType.adb

with ocpp.UploadLogStatusEnumType; use ocpp.UploadLogStatusEnumType;
with NonSparkTypes;

package body ocpp.UploadLogStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "BadMessage")) then
         attribute := BadMessage;
      elsif (NonSparkTypes.Uncased_Equals(str, "Idle")) then
         attribute := Idle;
      elsif (NonSparkTypes.Uncased_Equals(str, "NotSupportedOperation")) then
         attribute := NotSupportedOperation;
      elsif (NonSparkTypes.Uncased_Equals(str, "PermissionDenied")) then
         attribute := PermissionDenied;
      elsif (NonSparkTypes.Uncased_Equals(str, "Uploaded")) then
         attribute := Uploaded;
      elsif (NonSparkTypes.Uncased_Equals(str, "UploadFailure")) then
         attribute := UploadFailure;
      elsif (NonSparkTypes.Uncased_Equals(str, "Uploading")) then
         attribute := Uploading;
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
         when BadMessage => str := To_Bounded_String("BadMessage");
         when Idle => str := To_Bounded_String("Idle");
         when NotSupportedOperation => str := To_Bounded_String("NotSupportedOperation");
         when PermissionDenied => str := To_Bounded_String("PermissionDenied");
         when Uploaded => str := To_Bounded_String("Uploaded");
         when UploadFailure => str := To_Bounded_String("UploadFailure");
         when Uploading => str := To_Bounded_String("Uploading");
      end case;
   end ToString;
end ocpp.UploadLogStatusEnumType;

-- ocpp-PublishFirmwareStatusEnumType.adb

with ocpp.PublishFirmwareStatusEnumType; use ocpp.PublishFirmwareStatusEnumType;
with NonSparkTypes;

package body ocpp.PublishFirmwareStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "Downloaded")) then
         attribute := Downloaded;
      elsif (NonSparkTypes.Uncased_Equals(str, "DownloadFailed")) then
         attribute := DownloadFailed;
      elsif (NonSparkTypes.Uncased_Equals(str, "Downloading")) then
         attribute := Downloading;
      elsif (NonSparkTypes.Uncased_Equals(str, "DownloadScheduled")) then
         attribute := DownloadScheduled;
      elsif (NonSparkTypes.Uncased_Equals(str, "DownloadPaused")) then
         attribute := DownloadPaused;
      elsif (NonSparkTypes.Uncased_Equals(str, "PublishFailed")) then
         attribute := PublishFailed;
      elsif (NonSparkTypes.Uncased_Equals(str, "Published")) then
         attribute := Published;
      elsif (NonSparkTypes.Uncased_Equals(str, "InvalidChecksum")) then
         attribute := InvalidChecksum;
      elsif (NonSparkTypes.Uncased_Equals(str, "ChecksumVerified")) then
         attribute := ChecksumVerified;
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
         when Downloaded => str := To_Bounded_String("Downloaded");
         when DownloadFailed => str := To_Bounded_String("DownloadFailed");
         when Downloading => str := To_Bounded_String("Downloading");
         when DownloadScheduled => str := To_Bounded_String("DownloadScheduled");
         when DownloadPaused => str := To_Bounded_String("DownloadPaused");
         when PublishFailed => str := To_Bounded_String("PublishFailed");
         when Published => str := To_Bounded_String("Published");
         when InvalidChecksum => str := To_Bounded_String("InvalidChecksum");
         when ChecksumVerified => str := To_Bounded_String("ChecksumVerified");
      end case;
   end ToString;
end ocpp.PublishFirmwareStatusEnumType;

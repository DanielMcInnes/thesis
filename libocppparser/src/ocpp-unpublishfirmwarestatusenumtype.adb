-- ocpp-UnpublishFirmwareStatusEnumType.adb

with ocpp.UnpublishFirmwareStatusEnumType; use ocpp.UnpublishFirmwareStatusEnumType;
with NonSparkTypes;

package body ocpp.UnpublishFirmwareStatusEnumType is
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean)
   is
   begin
      if (NonSparkTypes.Uncased_Equals(str, "DownloadOngoing")) then
         attribute := DownloadOngoing;
      elsif (NonSparkTypes.Uncased_Equals(str, "NoFirmware")) then
         attribute := NoFirmware;
      elsif (NonSparkTypes.Uncased_Equals(str, "Unpublished")) then
         attribute := Unpublished;
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
         when DownloadOngoing => str := To_Bounded_String("DownloadOngoing");
         when NoFirmware => str := To_Bounded_String("NoFirmware");
         when Unpublished => str := To_Bounded_String("Unpublished");
      end case;
   end ToString;
end ocpp.UnpublishFirmwareStatusEnumType;

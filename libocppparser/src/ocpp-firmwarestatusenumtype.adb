-- ocpp-FirmwareStatusEnumType.adb

with ocpp.FirmwareStatusEnumType; use ocpp.FirmwareStatusEnumType;
with NonSparkTypes;

package body ocpp.FirmwareStatusEnumType is
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
      elsif (NonSparkTypes.Uncased_Equals(str, "Idle")) then
         attribute := Idle;
      elsif (NonSparkTypes.Uncased_Equals(str, "InstallationFailed")) then
         attribute := InstallationFailed;
      elsif (NonSparkTypes.Uncased_Equals(str, "Installing")) then
         attribute := Installing;
      elsif (NonSparkTypes.Uncased_Equals(str, "Installed")) then
         attribute := Installed;
      elsif (NonSparkTypes.Uncased_Equals(str, "InstallRebooting")) then
         attribute := InstallRebooting;
      elsif (NonSparkTypes.Uncased_Equals(str, "InstallScheduled")) then
         attribute := InstallScheduled;
      elsif (NonSparkTypes.Uncased_Equals(str, "InstallVerificationFailed")) then
         attribute := InstallVerificationFailed;
      elsif (NonSparkTypes.Uncased_Equals(str, "InvalidSignature")) then
         attribute := InvalidSignature;
      elsif (NonSparkTypes.Uncased_Equals(str, "SignatureVerified")) then
         attribute := SignatureVerified;
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
         when Idle => str := To_Bounded_String("Idle");
         when InstallationFailed => str := To_Bounded_String("InstallationFailed");
         when Installing => str := To_Bounded_String("Installing");
         when Installed => str := To_Bounded_String("Installed");
         when InstallRebooting => str := To_Bounded_String("InstallRebooting");
         when InstallScheduled => str := To_Bounded_String("InstallScheduled");
         when InstallVerificationFailed => str := To_Bounded_String("InstallVerificationFailed");
         when InvalidSignature => str := To_Bounded_String("InvalidSignature");
         when SignatureVerified => str := To_Bounded_String("SignatureVerified");
      end case;
   end ToString;
end ocpp.FirmwareStatusEnumType;

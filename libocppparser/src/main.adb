pragma SPARK_Mode (On);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;
with ocpp;
with ocpp.BootNotification;
with ocpp.server;
with NonSparkTypes;
with unittests;

procedure Main is
   retval: Boolean;

begin
   unittests.testall(retval);
   if (retval = false) then
      Put_line("Error: main.adb: 17: unittest failed");
      return;
   end if;

end Main;

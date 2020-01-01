pragma SPARK_Mode (On);

with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Command_Line;

with NonSparkTypes;
with ocpp;

package ocpp.heartbeat is

   type Request is new call with record
      reason: NonSparkTypes.BootReasonEnumType.Bounded_String := NonSparkTypes.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
      chargingStation: ChargingStation_t;
   end record;

   type Response is new callresult with record
      currentTime: NonSparkTypes.bootnotification_t.response.currentTime.Bounded_String := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
   end record;
   
   procedure DefaultInitialize(Self : out ocpp.BootNotification.Request);


end ocpp.heartbeat;

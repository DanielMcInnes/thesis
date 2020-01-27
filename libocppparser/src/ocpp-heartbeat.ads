pragma SPARK_Mode (On);

with Ada.Finalization;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Command_Line;

with NonSparkTypes; use NonSparkTypes.action_t;
with ocpp;

package ocpp.heartbeat is
   pragma Elaborate_Body;
   action : constant String := "Heartbeat";

   type Request is new ocpp.call with null record;

   type Response is new callresult with record
      currentTime: NonSparkTypes.bootnotification_t.response.currentTime.Bounded_String := NonSparkTypes.bootnotification_t.response.currentTime.To_Bounded_String(""); --eg. 2013-02-01T20:53:32.486Z
   end record;
   
   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request);
   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request;
                               messageTypeId : Integer;
                               messageId : NonSparkTypes.messageid_t.Bounded_String;
                               action : NonSparkTypes.action_t.Bounded_String
                              );
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   request: in ocpp.heartbeat.Request;
                   valid: out Boolean
                  )
     with
       Global => null,
       Depends => (
                   valid => (msg, msgindex, request)
                  ),
       post => (if valid = true then
                  (request.messagetypeid = 2) and
                  (NonSparkTypes.messageid_t.Length(request.messageid) > 0) and
                  (request.action = action) and
                  (Index(NonSparkTypes.packet.To_String(msg), action) /= 0) -- prove that the original packet contains "BootNotification"
               );
   
   procedure To_Bounded_String(Self: in ocpp.heartbeat.Request;
                               retval: out NonSparkTypes.packet.Bounded_String);

end ocpp.heartbeat;

pragma SPARK_Mode (On);

with ocpp.heartbeat;

package body ocpp.heartbeat is

   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request) 
   is
   begin
      self.messagetypeid := 2;
      self.messageid := messageid_t.To_Bounded_String("19223201");
      self.action := action_t.To_Bounded_String("Heartbeat");
   end DefaultInitialize;
   
   procedure To_Bounded_String(Self: in ocpp.heartbeat.Request;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
   begin
        retval := NonSparkTypes.packet.To_Bounded_String( ""
                                                        & "[2," & ASCII.LF
                                                        & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) &'"' & "," & ASCII.LF
                                                        & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                        & "]");
   end To_Bounded_String;
   
end ocpp.heartbeat;

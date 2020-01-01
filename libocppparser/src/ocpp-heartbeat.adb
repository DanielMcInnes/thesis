package body ocpp.heartbeat is

   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request) 
   is
   begin
      self.messagetypeid := 2;
      self.messageid := messageid_t.To_Bounded_String("Heartbeat");
   end DefaultInitialize;
   

end ocpp.heartbeat;

pragma SPARK_Mode (On);

with ocpp.heartbeat;
with utils;

package body ocpp.heartbeat is

   procedure packetContainsString is new utils.contains(
                                                        string_haystack => NonSparkTypes.packet.Bounded_String, 
                                                        haystack_to_string => NonSparkTypes.packet.To_String,
                                                        haystack_length => NonSparkTypes.packet.Length
                                                       );

   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request) 
   is
   begin
      self.messagetypeid := 2;
      self.messageid := messageid_t.To_Bounded_String("19223201");
      self.action := action_t.To_Bounded_String("Heartbeat");
   end DefaultInitialize;
   
   procedure DefaultInitialize(Self : out ocpp.heartbeat.Request;
                               messageTypeId : Integer;
                               messageId : NonSparkTypes.messageid_t.Bounded_String;
                               action : NonSparkTypes.action_t.Bounded_String
                              )
   is
   begin
      self.messagetypeid := messageTypeId;
      self.messageid := messageId;
      self.action := action;
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
   
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   request: in ocpp.heartbeat.Request;
                   valid: out Boolean
                  )
   is
      retval: Boolean;
   begin
      valid := false;
      if request.messagetypeid /= 2 then
         NonSparkTypes.put_line("parse: Error: 142"); 
         return;
      end if;
      
      if (msgindex >= NonSparkTypes.packet.Length(msg))
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;
      if (msgindex < 1)
      then
         NonSparkTypes.put("***ERROR***"); NonSparkTypes.put(" index: "); NonSparkTypes.put(msgindex'Image);
         return;
      end if;      

      if (NonSparkTypes.messageid_t.Length(request.messageid) <= 0) then return; end if;
      if (request.action /= action) then return; end if;
      packetContainsString(msg, action, retval);      
      if retval = false then
         NonSparkTypes.put_line("parse: Error: 70"); 
         return;
      end if;

      valid := true;
   end parse;

end ocpp.heartbeat;

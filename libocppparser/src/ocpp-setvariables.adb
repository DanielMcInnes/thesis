pragma SPARK_Mode (On);

with ocpp.setvariables;
with utils;

package body ocpp.setvariables is
   procedure DefaultInitialize(Self : out ocpp.setvariables.Request.Class) 
   is
   begin
      self.messagetypeid := 2;
      self.messageid := messageid_t.To_Bounded_String("19223201");
      self.action := action;
   end DefaultInitialize;
   
   procedure DefaultInitialize(Self : out ocpp.setvariables.Request.Class;
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

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   response: in ocpp.setvariables.Response;
                   valid: out Boolean
                  )
   is
   begin
      valid := false;
      
      if response.messagetypeid /= 3 then
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

      if (NonSparkTypes.messageid_t.Length(response.messageid) <= 0) then return; end if;
      
      valid := true;
   end parse;

end ocpp.setvariables;

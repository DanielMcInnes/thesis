pragma SPARK_Mode (On);

with ocpp;
with ocpp.BootNotification;
with ocpp.heartbeat;

with NonSparkTypes;

package ocpp.server 
is 
   
   type Class is tagged record

      -- the server maintains a list of charger ids that are allowed to connect
      enrolledChargers : vecChargers_t; -- := NonSparkTypes.vector_chargers.To_Vector(New_Item => NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String(""), Length => 0);   

      reason: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); --eg. PowerUp
   end record;

   procedure enrolChargingStation(theList: in out NonSparkTypes.vecChargers_t;
                                  serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                                  retval: out Boolean)
     with
       Depends => (
                     retval => (serialNumber, theList),
                   theList => (serialNumber, theList)
                  );
   
   procedure isEnrolled(theList: in out NonSparkTypes.vecChargers_t;
                        serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                        retval: out Boolean)
     with
       Depends => (
                     retval => (serialNumber, theList),
                   theList => (serialNumber)
                  );

   procedure handle(theList: in out NonSparkTypes.vecChargers_t;
                    msg: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
     with
       Depends => (
                     response => (msg, theList),
                   theList => (msg, theList)
                  );

   procedure handleBootNotification(theList: in out NonSparkTypes.vecChargers_t;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
     with
       Depends => (
                     index => (msg, index),
                   valid => (msg, index),
                     response => (msg, index, theList, messageTypeId, messageId, action),
                   theList => (msg, theList)
                  );

   procedure handleHeartbeat(theList: in out NonSparkTypes.vecChargers_t;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String;
                                    messageTypeId : in Integer;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String;
                                    action : in NonSparkTypes.action_t.Bounded_String
                                   )
     with
       Depends => (
                     index => (msg, index),
                   valid => (msg, index),
                     response => (msg, index, theList, messageTypeId, messageId, action),
                   theList => (msg, theList)
                  );

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response);

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.heartbeat.Response);

   
end ocpp.server;

pragma SPARK_Mode (On);

with ocpp;
with ocpp.BootNotification;
with ocpp.GetBaseReportResponse;
with ocpp.heartbeat;
with ocpp.SetVariablesRequest;
with ocpp.SetVariablesResponse;
with ocpp.GetVariablesRequest;
with ocpp.GetVariablesResponse;

with NonSparkTypes;

package ocpp.server 
is 
   
   type Class is tagged record

      -- the server maintains a list of charger ids that are allowed to connect
      enrolledChargers : vecChargers_t; -- := NonSparkTypes.vector_chargers.To_Vector(New_Item => NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String(""), Length => 0); 

      getBaseReportResponse: ocpp.GetBaseReportResponse.T;
      getVariablesResponse: ocpp.GetVariablesResponse.T;
      isDeferringBootNotificationAccept: Boolean := false;
      setVariablesResponse: ocpp.SetVariablesResponse.T;
      call: NonSparkTypes.action_t.Bounded_String;
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

   procedure receivePacket(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
     with
       Depends => (
                     valid => (msg, theServer),
                     response => (msg, theServer),
                   theServer => (msg, theServer)
                  );
   
   procedure handleRequest(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
     with
       Depends => (
                     valid => (msg, theServer),
                     response => (msg, theServer),
                   theServer => (msg, theServer)
                  );
   
   procedure handleResponse(theServer: in out ocpp.server.Class;
                    msg: in NonSparkTypes.packet.Bounded_String;
                          valid: out Boolean)
     with
       Depends => (
                     valid => (msg, theServer),
                   theServer => (msg, theServer)
                  );
   
   procedure handleSetVariablesResponse(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String
                                   )
     with
       Depends => (
                     index => (msg, index),
                     valid => (msg, index,  messageId),
                   theServer => (msg, theServer)
                  );

   procedure handleGetBaseReportResponse(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String
                                   )
     with
       Depends => (
                     index => (msg, index),
                     valid => (msg, index,  messageId),
                   theServer => (msg, theServer)
                  );

   procedure handleGetVariablesResponse(theServer: in out ocpp.server.Class;
                                    msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    messageId : in NonSparkTypes.messageid_t.Bounded_String
                                   )
     with
       Depends => (
                     index => (msg, index),
                     valid => (msg, index,  messageId),
                   theServer => (msg, theServer)
                  );


   procedure sendRequest(theServer: in out ocpp.server.Class;
                            msg: in call'Class
                           );

   procedure handleBootNotification(theServer: in out ocpp.server.Class;
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
                     response => (msg, index, theServer, messageTypeId, messageId, action),
                     theServer => (msg, theServer)
                  );

   procedure handleHeartbeat(theServer: in out ocpp.server.Class;
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
                     response => (msg, index, theServer, messageTypeId, messageId, action),
                   theServer => (msg, theServer)
                  );

   procedure handleGetBaseReportRequest(theServer: in out ocpp.server.Class;
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
                     response => (msg, index, theServer, messageTypeId, messageId, action),
                   theServer => (msg, theServer)
                  );

   procedure handleStatusNotificationRequest(theServer: in out ocpp.server.Class;
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
                     response => (msg, index, theServer, messageTypeId, messageId, action),
                   theServer => (msg, theServer)
                  );

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response);

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.heartbeat.Response);

   
end ocpp.server;

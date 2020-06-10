pragma SPARK_Mode (On);

with ChargerList;
with ocpp;
with ocpp.BootNotificationRequest;
with ocpp.BootNotificationResponse;
with ocpp.GetBaseReportResponse;
with ocpp.GetVariablesRequest;
with ocpp.GetVariablesResponse;
with ocpp.HeartbeatResponse;
with ocpp.SetVariablesRequest;
with ocpp.SetVariablesResponse;
with ocpp.ResetResponse;

with NonSparkTypes;

package ocpp.server 
is 
   
   type T is tagged record

      -- the server maintains a list of charger ids that are allowed to connect
      enrolledChargers : ChargerList.vecChargers_t; -- := NonSparkTypes.vector_chargers.To_Vector(New_Item => NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String(""), Length => 0); 

      getBaseReportResponse: ocpp.GetBaseReportResponse.T;
      resetResponse: ocpp.ResetResponse.T;
      getVariablesResponse: ocpp.GetVariablesResponse.T;
      isDeferringBootNotificationAccept: Boolean := false;
      setVariablesResponse: ocpp.SetVariablesResponse.T;
      call: NonSparkTypes.action_t.Bounded_String;
   end record;
   procedure Initialize(self: out T)
     with
       global => null;

   procedure EnrolChargingStation(theList: in out ChargerList.vecChargers_t;
                                  serialNumber: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
                                  retval: out Boolean)
     with
       global => null,
       Depends => (
                     retval => (serialNumber, theList),
                   theList => (serialNumber, theList)
                  );
   
   procedure IsEnrolled(theList: in ChargerList.vecChargers_t;
                        serialNumber: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
                        retval: out Boolean)
     with
       global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                     retval => (serialNumber, theList)
                  );

   procedure ReceivePacket(theServer: in out ocpp.server.T;
                           msg: in NonSparkTypes.packet.Bounded_String;
                           response: out NonSparkTypes.packet.Bounded_String;
                           valid: out Boolean)
     with
       Global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                   valid => (msg, theServer),
                   response => (msg, theServer),
                   theServer => (msg, theServer)
                  );
   
   procedure HandleRequest(theServer: in ocpp.server.T;
                           msg: in NonSparkTypes.packet.Bounded_String;
                           msgindex: in out Integer;
                           response: out NonSparkTypes.packet.Bounded_String;
                           valid: out Boolean)
     with
       global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                     valid => (msg, msgindex),
                   msgindex => (msg, msgindex),
                   response => (msg, msgindex, theServer)
                  ),
       Post => (if valid = true then msgindex <= NonSparkTypes.packet.Length(msg));
   
   procedure HandleResponse(theServer: in out ocpp.server.T;
                            msg: in NonSparkTypes.packet.Bounded_String;
                           index: in out Integer;
                            valid: out Boolean)
     with
       global => null,
       Depends => (
                     valid => (msg, index, theServer),
                   index => (msg, index, theServer),
                   theServer => (msg, theServer)
                  );
   
   procedure HandleSetVariablesResponse(theServer: in out ocpp.server.T;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : out Integer;
                                        valid: out Boolean
                                       )
     with
       global => null,
       Depends => (
                     index => (msg),
                   valid => (msg),
                   theServer => (msg, theServer)
                  );

   procedure HandleGetBaseReportResponse(theServer: in out ocpp.server.T;
                                         msg: in NonSparkTypes.packet.Bounded_String;
                                         index : out Integer;
                                         valid: out Boolean
                                        )
     with
       global => null,
       Depends => (
                     index => (msg),
                   valid => (msg),
                   theServer => (msg, theServer)
                  );

   procedure HandleResetResponse(theServer: in out ocpp.server.T;
                                         msg: in NonSparkTypes.packet.Bounded_String;
                                         index : out Integer;
                                         valid: out Boolean
                                        )
     with
       global => null,
       Depends => (
                     index => (msg),
                   valid => (msg),
                   theServer => (msg, theServer)
                  );

   procedure HandleGetVariablesResponse(theServer: in out ocpp.server.T;
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : out Integer;
                                        valid: out Boolean
                                       )
     with
       global => null,
       Depends => (
                     index => (msg),
                   valid => (msg),
                   theServer => (msg, theServer)
                  );


   procedure SendRequest(theServer: in out ocpp.server.T;
                         msg: in call'Class
                        )
     with
       global => null;

   procedure HandleBootNotificationRequest(theServer: in ocpp.server.T;
                                           msg: in NonSparkTypes.packet.Bounded_String;
                                           index : out Integer;
                                           valid: out Boolean;
                                           response: out NonSparkTypes.packet.Bounded_String
                                          )
     with
       global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                     index => (msg),
                   valid => (msg),
                   response => (msg, theServer)
                  );

   procedure HandleHeartbeatRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                    index : in out Integer;
                                    valid: out Boolean;
                                    response: out NonSparkTypes.packet.Bounded_String
                                   )
     with
       global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                     index => (msg),
                   valid => (msg),
                   response => (msg),
                   null => index
                  );

   procedure HandleGetBaseReportRequest(
                                        msg: in NonSparkTypes.packet.Bounded_String;
                                        index : in out Integer;
                                        valid: out Boolean;
                                        response: out NonSparkTypes.packet.Bounded_String
                                       )
     with
       global => null,
       Annotate => (GNATprove, Terminating),
       Depends => (
                     index => (msg),
                   valid => (msg),
                   response => (msg),
                   null => index
                  );

   procedure HandleStatusNotificationRequest(msg: in NonSparkTypes.packet.Bounded_String;
                                             index : in out Integer;
                                             valid: out Boolean;
                                             response: out NonSparkTypes.packet.Bounded_String
                                            )
     with
       global => null,
       Depends => (
                     index => (msg),
                   valid => (msg),
                   response => (msg),
                   null => index
                  );

end ocpp.server;

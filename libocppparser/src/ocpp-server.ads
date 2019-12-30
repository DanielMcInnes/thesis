pragma SPARK_Mode (On);

with ocpp;
with ocpp.BootNotification;

package ocpp.server 
  with Abstract_State => State
is 
   
   type Class is tagged record

      -- the server maintains a list of charger ids that are allowed to connect
      enrolledChargers: vecChargers_t;
      
      reason: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); --eg. PowerUp
   end record;   

   procedure enrolChargingStation(theList : in out vecChargers_t;
                                  serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                                  retval: out Boolean)
     with
       Global => (null),
       Depends => (
                     theList => (theList, serialNumber),
                     --serialNumber => null,
                     retval => (theList, serialNumber)
                  );
   
   procedure isEnrolled(theList : in vecChargers_t;
                        serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                        retval: out Boolean)
          with
       Global => (null),
       Depends => (
                     retval => (theList, serialNumber)
                  );

   procedure handle(server: in Class;
                    request: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
     with
       Depends => (
                     response => (request, server)
                  );

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response);
   
end ocpp.server;

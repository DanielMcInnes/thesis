pragma SPARK_Mode (On);

with ocpp;
with ocpp.BootNotification;

package ocpp.server 
with Abstract_State => State, Initializes => State
is 
   
   type Class is tagged record

      reason: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); --eg. PowerUp
   
   end record;   

   procedure enrolChargingStation(
                                  serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                                  retval: out Boolean)
     with
       Global => (In_Out => State),
     Depends => (
                 retval => (serialNumber, State),
                 State => (serialNumber, State)
                );
   
   procedure isEnrolled(
                        serialNumber: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                        retval: out Boolean)
     with
       Global => (In_Out => State),
     Depends => (
                   retval => (serialNumber, State),
                 State => (serialNumber)
                );

   procedure handle(request: in NonSparkTypes.packet.Bounded_String;
                    response: out NonSparkTypes.packet.Bounded_String)
     with
       Global => (In_Out => State),
       Depends => (
                     response => (request, State),
                   State => (request, State)
                  );

   procedure toString(msg: out NonSparkTypes.packet.Bounded_String;
                      response: in ocpp.BootNotification.Response);
   
end ocpp.server;

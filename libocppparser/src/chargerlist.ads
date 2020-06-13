with ada.Containers.Vectors;
with NonSparkTypes;
with ocpp; use ocpp;
with ocpp.ChargingStationType;
with ChargingStationTypeStrings;

package ChargerList is

   use ChargingStationTypeStrings.strserialNumber_t;
   subtype index_t is Natural range 1 .. 100;  
   package vector_chargers is new Ada.Containers.Vectors
     (Index_Type => index_t, 
      Element_Type => ChargingStationTypeStrings.strserialNumber_t.Bounded_String);   
   subtype vecChargers_t is vector_chargers.Vector;

   procedure contains(theList : in vecChargers_t;
                      theValue: in ChargingStationTypeStrings.strserialNumber_t.Bounded_String;
                      retval: out Boolean)
     with  Global => null,
     Annotate => (GNATprove, Terminating);
   
   procedure append(theList : in out vecChargers_t;
                    retval : out Boolean;
                    theValue: in ChargingStationTypeStrings.strserialNumber_t.Bounded_String
                   )
     with
       Global => null;

   



end ChargerList;

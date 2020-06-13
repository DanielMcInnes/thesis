pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ChargingStationTypestrings;
with ocpp.ModemType; use ocpp.ModemType;

package ocpp.ChargingStationType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      serialNumber : ChargingStationTypeStrings.strserialNumber_t.Bounded_String;
      model : ChargingStationTypeStrings.strmodel_t.Bounded_String;
      modem : ModemType.T;
      vendorName : ChargingStationTypeStrings.strvendorName_t.Bounded_String;
      firmwareVersion : ChargingStationTypeStrings.strfirmwareVersion_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.ChargingStationType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.ChargingStationType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgindex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.ChargingStationType;
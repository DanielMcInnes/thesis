pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.ModemType; use ocpp.ModemType;

package ocpp.ChargingStationType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      serialNumber : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
      model : NonSparkTypes.ChargingStationType.strmodel_t.Bounded_String;
      modem : ModemType.T;
      vendorName : NonSparkTypes.ChargingStationType.strvendorName_t.Bounded_String;
      firmwareVersion : NonSparkTypes.ChargingStationType.strfirmwareVersion_t.Bounded_String;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex: in out Integer;
                self: in out ocpp.ChargingStationType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex, self),
                msgindex => (msg, msgIndex, self),
                self  => (msg, msgindex, self)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.ChargingStationType;
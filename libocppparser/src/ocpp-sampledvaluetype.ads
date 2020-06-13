pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with SampledValueTypestrings;
with ocpp.ReadingContextEnumType; use ocpp.ReadingContextEnumType;
with ocpp.MeasurandEnumType; use ocpp.MeasurandEnumType;
with ocpp.PhaseEnumType; use ocpp.PhaseEnumType;
with ocpp.LocationEnumType; use ocpp.LocationEnumType;
with ocpp.SignedMeterValueType; use ocpp.SignedMeterValueType;
with ocpp.UnitOfMeasureType; use ocpp.UnitOfMeasureType;

package ocpp.SampledValueType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      value : Integer;
      context : ReadingContextEnumType.T;
      measurand : MeasurandEnumType.T;
      phase : PhaseEnumType.T;
      location : LocationEnumType.T;
      signedMeterValue : SignedMeterValueType.T;
      unitOfMeasure : UnitOfMeasureType.T;
   end record;
   procedure Initialize(self: out ocpp.SampledValueType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.SampledValueType.T;
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
end ocpp.SampledValueType;
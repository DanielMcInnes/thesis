pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with SignedMeterValueTypestrings;

package ocpp.SignedMeterValueType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      signedMeterData : SignedMeterValueTypeStrings.strsignedMeterData_t.Bounded_String;
      signingMethod : SignedMeterValueTypeStrings.strsigningMethod_t.Bounded_String;
      encodingMethod : SignedMeterValueTypeStrings.strencodingMethod_t.Bounded_String;
      publicKey : SignedMeterValueTypeStrings.strpublicKey_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.SignedMeterValueType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.SignedMeterValueType.T;
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
end ocpp.SignedMeterValueType;
pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.HashAlgorithmEnumType; use ocpp.HashAlgorithmEnumType;

package ocpp.OCSPRequestDataType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      hashAlgorithm : HashAlgorithmEnumType.T;
      issuerNameHash : NonSparkTypes.OCSPRequestDataType.strissuerNameHash_t.Bounded_String;
      issuerKeyHash : NonSparkTypes.OCSPRequestDataType.strissuerKeyHash_t.Bounded_String;
      serialNumber : NonSparkTypes.OCSPRequestDataType.strserialNumber_t.Bounded_String;
      responderURL : NonSparkTypes.OCSPRequestDataType.strresponderURL_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.OCSPRequestDataType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.OCSPRequestDataType.T;
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
end ocpp.OCSPRequestDataType;
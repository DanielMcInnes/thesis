pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.integerType;
with ocpp.OCSPRequestDataType;

package ocpp.iso15118CertificateHashDataTypeArray is
type Index is range 1 .. 10;
type array_OCSPRequestDataType is array (Index) of ocpp.OCSPRequestDataType.T;
type T is record
   content : array_OCSPRequestDataType;
end record;
procedure Initialize(self: out ocpp.iso15118CertificateHashDataTypeArray.T)
  with
Global => null,
Annotate => (GNATprove, Terminating);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.iso15118CertificateHashDataTypeArray;

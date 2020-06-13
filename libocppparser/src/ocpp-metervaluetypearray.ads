pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.integerType;
with ocpp.MeterValueType;

package ocpp.meterValueTypeArray is
type Index is range 1 .. 10;
type array_MeterValueType is array (Index) of ocpp.MeterValueType.T;
type T is record
   content : array_MeterValueType;
end record;
procedure Initialize(self: out ocpp.meterValueTypeArray.T)
  with
Global => null,
Annotate => (GNATprove, Terminating);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.meterValueTypeArray;

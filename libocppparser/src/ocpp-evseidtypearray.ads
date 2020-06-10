pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.integerType;
package ocpp.evseIdTypeArray is
type Index is range 1 .. 10;
type array_integerType is array (Index) of ocpp.integerType.T;
type T is record
   content : array_integerType;
end record;
procedure Initialize(self: out ocpp.evseIdTypeArray.T)
  with
Global => null,
Annotate => (GNATprove, Terminating);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.evseIdTypeArray;

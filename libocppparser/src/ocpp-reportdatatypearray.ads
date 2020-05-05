pragma SPARK_mode (on); 

with NonSparkTypes;
with ocpp.ReportDataType;

package ocpp.ReportDataTypeArray is
type Index is range 1 .. 10;
type array_ReportDataType is array (Index) of ocpp.ReportDataType.T;
type T is record
   content : array_ReportDataType;
end record;
procedure Initialize(self: out ocpp.ReportDataTypeArray.T);

procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;
                     msgindex: in out Integer;
                     self: out T;
                     valid: out Boolean);

procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;
                   self: in T);

end ocpp.ReportDataTypeArray;

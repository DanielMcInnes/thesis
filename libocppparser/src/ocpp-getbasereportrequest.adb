pragma SPARK_mode (on); 

with ocpp.GetBaseReportRequest;
package body ocpp.GetBaseReportRequest is 
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   packet: in ocpp.GetBaseReportRequest.T;
                   valid: out Boolean
                  )
   is
   begin
      checkValid(msg, msgindex, packet, valid);
   end parse;
   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
   begin
      retval := NonSparkTypes.packet.To_Bounded_String("blah");
   end To_Bounded_String;
end ocpp.GetBaseReportRequest;

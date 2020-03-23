package body ocpp.customdatatype is

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   self: out ocpp.CustomDataType.T;
                   valid: out Boolean
                  )
   is
   begin
      valid := false;
      self.vendorId := CustomDataType.vendorId_t.To_Bounded_String("blah");
      valid := true;
   end parse;
   
   

end ocpp.customdatatype;

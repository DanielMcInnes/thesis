with Ada.Strings.Bounded;

with NonSparkTypes;

package ocpp.CustomDataType is
   package vendorId_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 255);
   type T is tagged record
      vendorId : vendorId_t.Bounded_String;
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in Integer;
                   self: out ocpp.CustomDataType.T;
                   valid: out Boolean
                  )
     with
       Global => null,
       Depends => (
                   valid => (msg, msgindex),
                   self => (msg, msgindex)
                  ),
       post => (if valid = true then
                  (vendorId_t.Length(self.vendorId) /= 0)
               );
   
   
end ocpp.CustomDataType;

with NonSparkTypes;
with Ada.Strings; use Ada.Strings;

package body ocpp.integerType is

   procedure Initialize(self: out ocpp.integerType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.value := -1;
   end Initialize;
   
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.integerType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findnextinteger(msg, msgindex, self.value, self.zzzArrayElementInitialized);
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(self.value'Image, Drop => Right);
   end To_Bounded_String;

end ocpp.integerType;

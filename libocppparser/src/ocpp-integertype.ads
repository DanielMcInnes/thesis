package ocpp.integerType is

   type T is record
      zzzArrayElementInitialized : Boolean := False;
      value: Integer;
   end record;
   procedure Initialize(self: out ocpp.integerType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
     Depends => (self => null);
   
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.integerType.T;
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
   

end ocpp.integerType;

package ocpp.server is 
   type Class is tagged record
      reason: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String(""); --eg. PowerUp
   end record;   
      procedure P(object : Class);
end ocpp.server;

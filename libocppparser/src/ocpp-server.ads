with ada.Containers.Bounded_Vectors;
with ada.Containers.Vectors;
with ada.Strings;
with ocpp;

package ocpp.server is 
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);

   package vector_int is new Ada.Containers.Vectors(Index_Type => Positive, Element_Type => Positive);
   --type vector_int is new Ada.Containers.Bounded_Vectors(Capacity => 500, Index_Type => Positive, Element_Type => string);
   type Class is tagged record
      -- the server maintains a list of charger ids that are allowed to connect
      reason: ocpp.packet.Bounded_String := ocpp.packet.To_Bounded_String(""); --eg. PowerUp
   end record;   
      procedure P(object : Class);
end ocpp.server;

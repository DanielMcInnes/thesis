
with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded; 
with Ada.Text_IO;

package NonSparkTypes is
   pragma Annotate(GNATprove, Terminating, NonSparkTypes);
   
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5000);
   package messageid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package action_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);

   procedure put(msg : string);
   procedure put_line(msg : string);

   function Uncased_Equals (L, R : String) return Boolean;

end NonSparkTypes;

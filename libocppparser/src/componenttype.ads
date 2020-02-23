
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with EVSEType;
with NonSparkTypes;

package ComponentType is

   package name is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   package instance is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);      
   
   type Class is tagged record
      name: ComponentType.name.Bounded_String;
      instance: ComponentType.instance.Bounded_String;
      evse: EVSEType.Class;
   end record;
end ComponentType;

with Ada.Containers; use Ada.Containers;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants; use Ada.Strings.Maps.Constants;

package body NonSparkTypes is
   procedure put(msg : string)
   is
   begin
      ada.Text_IO.put(msg);
   end put;

   procedure put_line(msg : string)
   is
   begin
      ada.Text_IO.put_line(msg);
   end put_line;

   function Uncased_Equals (L, R : String) return Boolean
   is
      use Ada.Strings.Fixed;
      use Ada.Strings.Maps.Constants;
   begin
      return Translate (L, Lower_Case_Map) = Translate (R, Lower_Case_Map);
   end Uncased_Equals;


end NonSparkTypes;

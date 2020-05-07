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

   procedure put(msg : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String)
   is
   begin
      ada.Text_IO.put(NonSparkTypes.ChargingStationType.strserialNumber_t.To_String(msg));
   end;

   procedure put_line(msg : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String)
   is
   begin
      ada.Text_IO.put_line(NonSparkTypes.ChargingStationType.strserialNumber_t.To_String(msg));
   end;

   function Uncased_Equals (L, R : String) return Boolean
   is
      use Ada.Strings.Fixed;
      use Ada.Strings.Maps.Constants;
   begin
      return Translate (L, Lower_Case_Map) = Translate (R, Lower_Case_Map);
   end Uncased_Equals;

   package body attributeValue_t is
      procedure FromString(attribute : in string;
                           str : out string_t.Bounded_String)
      is
      begin
         str := attributeValue_t.string_t.To_Bounded_String(attribute, Drop => Right);
      end FromString;

   end attributeValue_t;





end NonSparkTypes;

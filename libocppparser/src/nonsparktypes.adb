with Ada.Strings; use Ada.Strings;
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

   procedure put(msg : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String)
   is
   begin
      ada.Text_IO.put(NonSparkTypes.ChargingStationType.serialNumber.To_String(msg));
   end;

   procedure put_line(msg : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String)
   is
   begin
      ada.Text_IO.put_line(NonSparkTypes.ChargingStationType.serialNumber.To_String(msg));
   end;

   procedure contains(theList : in out vecChargers_t;
                      theValue: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                      retval: out Boolean)
   is
   begin
      retval := theList.Contains(theValue);
      --retval := NonSparkTypes.vector_chargers.Contains(theList, theValue);

   end contains;

   procedure append(theList : in out vecChargers_t;
                    theValue: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String
                   )
   is
   begin
      NonSparkTypes.vector_chargers.Append(theList, theValue);
   end append;

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

with Ada.Strings; use Ada.Strings;

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


end NonSparkTypes;

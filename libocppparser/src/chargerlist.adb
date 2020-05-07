package body ChargerList is

   procedure contains(theList : in vecChargers_t;
                      theValue: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String;
                      retval: out Boolean)
   is
   begin
      retval := theList.Contains(theValue);
      --retval := NonSparkTypes.vector_chargers.Contains(theList, theValue);

   end contains;

   procedure append(theList : in out vecChargers_t;
                    retval : out Boolean;
                    theValue: in NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String
                   )
   is

   begin
      if (theList.Length'Image = index_t'Last'Image) then
         NonSparkTypes.put("Capacity: "); NonSparkTypes.put(theList.Capacity'Image);
         NonSparkTypes.put(" Length: "); NonSparkTypes.put(theList.Length'Image);
         NonSparkTypes.put_line("Failed to enrol charging station");
         retval := false;
         return;
      end if;

      theList.Append(theValue);
      --NonSparkTypes.vector_chargers.Append(theList, theValue);
      retval := True;
   end append;

   

end ChargerList;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.UnitOfMeasureType;
with Ada.Strings; use Ada.Strings;

package body ocpp.UnitOfMeasureType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.UnitOfMeasureType.T)
   is
   begin
      self.zzzArrayElementInitialized := False;
      self.unit := UnitOfMeasureTypeStrings.strunit_t.To_Bounded_String("");
      self.multiplier := -1;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.UnitOfMeasureType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "unit", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid UnitOfMeasureTypeunit"); return; end if;

      self.unit := UnitOfMeasureTypeStrings.strunit_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "multiplier", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid UnitOfMeasureTypemultiplier"); return; end if;
      self.multiplier := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid UnitOfMeasureTypemultiplier"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "unit" & '"' & ": " & '"' & UnitOfMeasureTypeStrings.strunit_t.To_String(Self.unit) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "multiplier" & '"' & ": " & Self.multiplier'Image & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.UnitOfMeasureType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.VariableCharacteristicsType;
with Ada.Strings; use Ada.Strings;

package body ocpp.VariableCharacteristicsType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.VariableCharacteristicsType.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.zzzArrayElementInitialized := False;
      self.unit := NonSparkTypes.VariableCharacteristicsType.strunit_t.To_Bounded_String("");
      self.dataType := DataEnumType.zzzstring;
      self.minLimit := -1;
      self.maxLimit := -1;
      self.valuesList := NonSparkTypes.VariableCharacteristicsType.strvaluesList_t.To_Bounded_String("");
      self.supportsMonitoring := False;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.VariableCharacteristicsType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "unit", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableCharacteristicsTypeunit"); return; end if;

      self.unit := NonSparkTypes.VariableCharacteristicsType.strunit_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "dataType", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableCharacteristicsTypedataType"); return; end if;

      ocpp.DataEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.dataType, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid VariableCharacteristicsTypedataType"); return; end if;



      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "valuesList", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableCharacteristicsTypevaluesList"); return; end if;

      self.valuesList := NonSparkTypes.VariableCharacteristicsType.strvaluesList_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);


      if (valid = false) then NonSparkTypes.put_line("365 Invalid VariableCharacteristicsTypesupportsMonitoring"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strdataType : DataEnumType.string_t.Bounded_String;
   begin
      DataEnumType.ToString(Self.dataType, strdataType);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "unit" & '"' & ": " & '"' & NonSparkTypes.VariableCharacteristicsType.strunit_t.To_String(Self.unit) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "dataType" & '"' & ":"  & '"' & DataEnumType.string_t.To_String(strdataType) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "minLimit" & '"' & ": " & Self.minLimit'Image & "," & ASCII.LF
                                                      & "    " & '"' & "maxLimit" & '"' & ": " & Self.maxLimit'Image & "," & ASCII.LF
                                                      & "    " & '"' & "valuesList" & '"' & ": " & '"' & NonSparkTypes.VariableCharacteristicsType.strvaluesList_t.To_String(Self.valuesList) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "supportsMonitoring" & '"' & ": " & Self.supportsMonitoring'Image & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.VariableCharacteristicsType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.VariableAttributeType;
with Ada.Strings; use Ada.Strings;

package body ocpp.VariableAttributeType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.VariableAttributeType.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.zzzArrayElementInitialized := False;
      self.zzztype := AttributeEnumType.Actual;
      self.value := NonSparkTypes.VariableAttributeType.strvalue_t.To_Bounded_String("");
      self.mutability := MutabilityEnumType.ReadOnly;
      self.persistent := False;
      self.zzzconstant := False;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.VariableAttributeType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "type", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableAttributeTypetype"); return; end if;

      ocpp.AttributeEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.zzztype, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid VariableAttributeTypetype"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "value", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableAttributeTypevalue"); return; end if;

      self.value := NonSparkTypes.VariableAttributeType.strvalue_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "mutability", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableAttributeTypemutability"); return; end if;

      ocpp.MutabilityEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.mutability, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid VariableAttributeTypemutability"); return; end if;



      if (valid = false) then NonSparkTypes.put_line("365 Invalid VariableAttributeTypeconstant"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strtype : AttributeEnumType.string_t.Bounded_String;
      strmutability : MutabilityEnumType.string_t.Bounded_String;
   begin
      AttributeEnumType.ToString(Self.zzztype, strtype);
      MutabilityEnumType.ToString(Self.mutability, strmutability);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "       " & '"' & "type" & '"' & ":"  & '"' & AttributeEnumType.string_t.To_String(strtype) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "value" & '"' & ": " & '"' & NonSparkTypes.VariableAttributeType.strvalue_t.To_String(Self.value) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "mutability" & '"' & ":"  & '"' & MutabilityEnumType.string_t.To_String(strmutability) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "persistent" & '"' & ": " & Self.persistent'Image & "," & ASCII.LF
                                                      & "    " & '"' & "zzzconstant" & '"' & ": " & Self.zzzconstant'Image & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.VariableAttributeType;

pragma SPARK_mode (on); 

with ocpp;
with ocpp.VariableType;
with Ada.Strings; use Ada.Strings;

package body ocpp.VariableType is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.VariableType.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.zzzArrayElementInitialized := False;
      self.name := NonSparkTypes.VariableType.strname_t.To_Bounded_String("");
      self.instance := NonSparkTypes.VariableType.strinstance_t.To_Bounded_String("");

   end Initialize;
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out ocpp.VariableType.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "name", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableTypename"); return; end if;

      self.name := NonSparkTypes.VariableType.strname_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "instance", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid VariableTypeinstance"); return; end if;

      self.instance := NonSparkTypes.VariableType.strinstance_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      if (valid = false) then NonSparkTypes.put_line("365 Invalid VariableTypeinstance"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
   begin
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "name" & '"' & ": " & '"' & NonSparkTypes.VariableType.strname_t.To_String(Self.name) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "instance" & '"' & ": " & '"' & NonSparkTypes.VariableType.strinstance_t.To_String(Self.instance) & '"' & ASCII.LF
                                                      & "}" & ASCII.LF
, Drop => Right);
   end To_Bounded_String;
end ocpp.VariableType;

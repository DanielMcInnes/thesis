pragma SPARK_mode (on); 

with ocpp;
with ocpp.SetVariablesResponse;
with Ada.Strings; use Ada.Strings;

package body ocpp.SetVariablesResponse is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.SetVariablesResponse.T;
                   valid: out Boolean
                  )
   is
      strsetVariableResult: NonSparkTypes.packet.Bounded_String;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      checkValid(msg, msgindex, self, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "setVariableResult", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      SetVariableResultTypeArray.FromString(msg, msgindex, self.setVariableResult, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strsetVariableResult: NonSparkTypes.packet.Bounded_String;
   begin
      SetVariableResultTypeArray.To_Bounded_String(strsetVariableResult, self.setVariableResult);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[3," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & NonSparkTypes.packet.To_String(strsetVariableResult) & '"' & ": " & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.SetVariablesResponse;

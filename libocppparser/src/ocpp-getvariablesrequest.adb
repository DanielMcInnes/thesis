pragma SPARK_mode (on); 

with ocpp;
with ocpp.GetVariablesRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.GetVariablesRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: in out ocpp.GetVariablesRequest.T;
                   valid: out Boolean
                  )
   is
      strgetVariableData: NonSparkTypes.packet.Bounded_String;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "getVariableData", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      GetVariableDataTypeArray.ToString(strgetVariableData, self.getVariableData);
      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;

      if (valid = false) then NonSparkTypes.put_line("Invalid [object Object]"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strgetVariableData: NonSparkTypes.packet.Bounded_String;
   begin
      GetVariableDataTypeArray.ToString(strgetVariableData, self.getVariableData);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & NonSparkTypes.packet.To_String(strgetVariableData) & '"' & ": "
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.GetVariablesRequest;

pragma SPARK_Mode (On);

with ocpp.VariableType;
with ocpp; use ocpp;
with NonSparkTypes;

package body ocpp.VariableType is
   procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length,
                                                             string_t => NonSparkTypes.packet.Bounded_String,
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out VariableType.Class;
                   valid: out Boolean
                  )
   is
         dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
         tempmsgindex: Integer;
   begin
      NonSparkTypes.put_line("ocpp.VariableType: parse");
      valid := false;
      self.name := NonSparkTypes.VariableType_t.name.To_Bounded_String("");
      self.instance := NonSparkTypes.VariableType_t.instance.To_Bounded_String("");
      if ((msgindex < 1) or (msgindex > NonSparkTypes.packet.Max_Length)) then return; end if;
      findquotedstring_packet(msg, msgindex, valid, dummybounded);
      if ((msgindex < 1) or (msgindex > NonSparkTypes.packet.Max_Length)) then return; end if;
      if (valid = false) then return; end if;
      if (NonSparkTypes.packet.To_String(dummybounded) /= "variable")
      then
         valid := false;

         NonSparkTypes.put_line("ocpp.VariableType: parse: ERROR 37");
         return;
      end if;

      if ((msgindex < 1) or (msgindex > NonSparkTypes.packet.Max_Length)) then return; end if;
      ocpp.move_index_past_token(msg, ':', msgindex, tempmsgindex);
      if (tempmsgindex = 0) then valid := false;       NonSparkTypes.put_line("ocpp.VariableType: parse: ERROR 43"); return; end if;
      if ((msgindex < 1) or (msgindex > NonSparkTypes.packet.Max_Length)) then return; end if;
      ocpp.move_index_past_token(msg, '{', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;

      findQuotedKeyQuotedValue(msg, msgindex, valid, "name", dummybounded);
      if (valid = false) then return; end if;

      self.name :=
        NonSparkTypes.VariableType_t.name.To_Bounded_String(
                                            NonSparkTypes.packet.To_String(dummybounded),
                                            Drop => Ada.Strings.Right);
      ocpp.move_index_past_token(msg, ',', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;

      findQuotedKeyQuotedValue(msg, msgindex, valid, "instance", dummybounded);
      if (msgindex < 1) then valid := false; return; end if;
      pragma assert(msgindex > 0);
      if (valid = false) then return; end if;

      self.instance :=
        NonSparkTypes.VariableType_t.instance.To_Bounded_String(
                                                NonSparkTypes.packet.To_String(dummybounded),
                                                Drop => Ada.Strings.Right);
      ocpp.move_index_past_token(msg, ',', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;

      ocpp.move_index_past_token(msg, '}', msgindex, tempmsgindex); if (tempmsgindex = 0) then valid := false; return; end if;

      if (msgindex < 1) then valid := false; return; end if;
      pragma assert(msgindex > 0);

   end parse;


end ocpp.VariableType;

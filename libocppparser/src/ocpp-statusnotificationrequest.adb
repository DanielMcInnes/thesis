pragma SPARK_mode (on); 

with ocpp;
with ocpp.StatusNotificationRequest;
with Ada.Strings; use Ada.Strings;

package body ocpp.StatusNotificationRequest is 

procedure findquotedstring_packet is new findquotedstring(
                                                             Max => NonSparkTypes.packet.Max_Length, 
                                                             string_t => NonSparkTypes.packet.Bounded_String, 
                                                             length => NonSparkTypes.packet.Length,
                                                             To_String => NonSparkTypes.packet.to_string,
                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String
                                                            );

   procedure Initialize(self: out ocpp.StatusNotificationRequest.T)
   is
   begin
      NonSparkTypes.put_line("Initialize()");
      self.messageTypeId:= -1;
      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");
      self.action := NonSparkTypes.action_t.To_Bounded_String("");
      self.timestamp := NonSparkTypes.StatusNotificationRequest.strtimestamp_t.To_Bounded_String("");
      self.connectorStatus := ConnectorStatusEnumType.Available;
      self.evseId := -1;
      self.connectorId := -1;

   end Initialize;

   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: out Integer;
                   self: out ocpp.StatusNotificationRequest.T;
                   valid: out Boolean
                  )
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      dummyInt: integer;
   begin
      Initialize(self);
      msgIndex := 1;
      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("413 Invalid StatusNotificationRequestconnectorId messagetypeid"); return; end if;

      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);
      if (valid = false) then NonSparkTypes.put_line("416 Invalid StatusNotificationRequestconnectorId messageid"); return; end if;

      ocpp.ParseAction(msg, msgindex, self.action, valid);
      if (valid = false) then NonSparkTypes.put_line("404 Invalid action"); return; end if; 

      checkValid(msg, msgindex, self, action, valid);
      if (valid = false) then NonSparkTypes.put_line("313 Invalid StatusNotificationRequestconnectorId"); return; end if;

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "timestamp", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid StatusNotificationRequesttimestamp"); return; end if;

      self.timestamp := NonSparkTypes.StatusNotificationRequest.strtimestamp_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);

      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "connectorStatus", dummybounded);
      if (valid = false) then NonSparkTypes.put_line("333 Invalid StatusNotificationRequestconnectorStatus"); return; end if;

      ocpp.ConnectorStatusEnumType.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.connectorStatus, valid);
      if (valid = false) then NonSparkTypes.put_line("334 Invalid StatusNotificationRequestconnectorStatus"); return; end if;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "evseId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid StatusNotificationRequestevseId"); return; end if;
      self.evseId := dummyInt;

      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "connectorId", dummyInt);
      if (valid = false) then NonSparkTypes.put_line("328 Invalid StatusNotificationRequestconnectorId"); return; end if;
      self.connectorId := dummyInt;

      if (valid = false) then NonSparkTypes.put_line("365 Invalid StatusNotificationRequestconnectorId"); return; end if;
      valid := true;
   end parse;

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
   is
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); 
      strconnectorStatus : ConnectorStatusEnumType.string_t.Bounded_String;
   begin
      ConnectorStatusEnumType.ToString(Self.connectorStatus, strconnectorStatus);
      retval := NonSparkTypes.packet.To_Bounded_String(""
                                                      & "[2," & ASCII.LF
                                                      & '"'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & '"' & "," & ASCII.LF
                                                      & '"' & NonSparkTypes.action_t.To_String(Self.action) & '"' & "," & ASCII.LF
                                                      & "{" & ASCII.LF
                                                      & "    " & '"' & "timestamp" & '"' & ": " & '"' & NonSparkTypes.StatusNotificationRequest.strtimestamp_t.To_String(Self.timestamp) & '"' & "," & ASCII.LF
                                                      & "       " & '"' & "connectorStatus" & '"' & ":"  & '"' & ConnectorStatusEnumType.string_t.To_String(strconnectorStatus) & '"' & "," & ASCII.LF
                                                      & "    " & '"' & "evseId" & '"' & ": " & Self.evseId'Image & "," & ASCII.LF
                                                      & "    " & '"' & "connectorId" & '"' & ": " & Self.connectorId'Image & ASCII.LF
                                                      & "}" & ASCII.LF
                                                      & "]", Drop => Right);
   end To_Bounded_String;
end ocpp.StatusNotificationRequest;

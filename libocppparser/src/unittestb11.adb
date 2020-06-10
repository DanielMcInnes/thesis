with NonSparkTypes; use NonSparkTypes;
with ocpp; use ocpp;
with ocpp.ResetEnumType;
with ocpp.ResetStatusEnumType;
with ocpp.ResetRequest;
with ocpp.ResetResponse;
with ocpp.server;

package body unittestb11 is
   procedure test(result: out Boolean)
   is
      dummystring: NonSparkTypes.packet.Bounded_String;
      resetRequest: ocpp.ResetRequest.T := (
                                            messagetypeid => 2,
                                            action => NonSparkTypes.action_t.To_Bounded_String("Reset"),
                                            zzztype => ResetEnumType.Immediate,
                                            evseId => 0,
                                            messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202")
                                           );
      resetResponse: ocpp.ResetResponse.T := (
                                         messagetypeid => 3,
                                         messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
                                         status => ResetStatusEnumType.Accepted
                                        );
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;
      
   begin      
      NonSparkTypes.put_line("B11 - sendingResetRequest");
      server.sendRequest(resetRequest);
      
      resetResponse.To_Bounded_String(packet);
      server.ReceivePacket(packet, dummystring, result);
      
   end test;
   
end unittestb11;

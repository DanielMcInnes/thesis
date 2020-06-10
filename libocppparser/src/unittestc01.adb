with NonSparkTypes; use NonSparkTypes;
with ocpp; use ocpp;
with ocpp.server;

with ocpp.AuthorizeRequest; 
with ocpp.AuthorizeResponse;
with ocpp.HashAlgorithmEnumType; use ocpp.HashAlgorithmEnumType;
with ocpp.IdTokenEnumType;

package body unittestc01 is
   procedure test(result: out Boolean)
   is
      dummystring: NonSparkTypes.packet.Bounded_String;
      server: ocpp.server.T;
      sn : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("01234567890123456789");
      packet: NonSparkTypes.packet.Bounded_String;
      response: NonSparkTypes.packet.Bounded_String;
      expectedresponse: NonSparkTypes.packet.Bounded_String;

      authorizeRequest: ocpp.AuthorizeRequest.T := 
        (messagetypeid => 2,
         messageid => NonSparkTypes.messageid_t.To_Bounded_String("19223202"),
         action => action_t.To_Bounded_String("Authorize"),
         idToken => (
                     zzzArrayElementInitialized => true,
                     additionalInfo => (
                                        content => (
                                                    1 => (
                                                               zzzArrayElementInitialized => true,
                                                               additionalIdToken => NonSparkTypes.AdditionalInfoType.stradditionalIdToken_t.To_Bounded_String("blah"),
                                                               zzztype => NonSparkTypes.AdditionalInfoType.strtype_t.To_Bounded_String("blah")
                                                         ),
                                                    others => (
                                                               zzzArrayElementInitialized => false,
                                                               additionalIdToken => NonSparkTypes.AdditionalInfoType.stradditionalIdToken_t.To_Bounded_String("blah"),
                                                               zzztype => NonSparkTypes.AdditionalInfoType.strtype_t.To_Bounded_String("blah")
                                                              
                                                              )
                                                   )
                                       ),
                     idToken => NonSparkTypes.IdTokenType.stridToken_t.To_Bounded_String("blah"),
                     zzzType => ocpp.IdTokenEnumType.Central
                    ),
         iso15118CertificateHashData => (
                                         content => (
                                                     1 => (
                                                           zzzArrayElementInitialized => true,
                                                           hashAlgorithm => HashAlgorithmEnumType.SHA256,
                                                           issuerNameHash => NonSparkTypes.OCSPRequestDataType.strissuerNameHash_t.To_Bounded_String("blah"),
                                                           issuerKeyHash => NonSparkTypes.OCSPRequestDataType.strissuerKeyHash_t.To_Bounded_String("blah"),
                                                           serialNumber => NonSparkTypes.OCSPRequestDataType.strserialNumber_t.To_Bounded_String("blah"),
                                                           responderURL => NonSparkTypes.OCSPRequestDataType.strresponderURL_t.To_Bounded_String("blah")
                                                          ),
                                                     others => (
                                                                zzzArrayElementInitialized => false,
                                                                hashAlgorithm => HashAlgorithmEnumType.SHA256,
                                                                issuerNameHash => NonSparkTypes.OCSPRequestDataType.strissuerNameHash_t.To_Bounded_String("blah"),
                                                                issuerKeyHash => NonSparkTypes.OCSPRequestDataType.strissuerKeyHash_t.To_Bounded_String("blah"),
                                                                serialNumber => NonSparkTypes.OCSPRequestDataType.strserialNumber_t.To_Bounded_String("blah"),
                                                                responderURL => NonSparkTypes.OCSPRequestDataType.strresponderURL_t.To_Bounded_String("blah")
                                                               )
                                                    )
                                        )
        );
      
   begin
      result := false;

      authorizeRequest.To_Bounded_String(dummystring);
      NonSparkTypes.put_line("C01 - AuthorizationRequest. Receiving:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(dummystring));      
      
      server.ReceivePacket(dummystring, response, result); 
      NonSparkTypes.put_line("C01 - AuthorizationRequest. Sending:");
      NonSparkTypes.put_line(NonSparkTypes.packet.To_String(response));      
      

   end test;
   
end unittestc01;

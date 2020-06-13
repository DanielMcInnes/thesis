pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with IdTokenInfoTypestrings;
with ocpp.evseIdTypeArray;
with ocpp.AuthorizationStatusEnumType; use ocpp.AuthorizationStatusEnumType;
with ocpp.GroupIdTokenType; use ocpp.GroupIdTokenType;
with ocpp.MessageContentType; use ocpp.MessageContentType;

package ocpp.IdTokenInfoType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      status : AuthorizationStatusEnumType.T;
      cacheExpiryDateTime : IdTokenInfoTypeStrings.strcacheExpiryDateTime_t.Bounded_String;
      chargingPriority : integer;
      language1 : IdTokenInfoTypeStrings.strlanguage1_t.Bounded_String;
      evseId : evseIdTypeArray.T;
      groupIdToken : GroupIdTokenType.T;
      language2 : IdTokenInfoTypeStrings.strlanguage2_t.Bounded_String;
      personalMessage : MessageContentType.T;
   end record;
   procedure Initialize(self: out ocpp.IdTokenInfoType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.IdTokenInfoType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgindex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.IdTokenInfoType;
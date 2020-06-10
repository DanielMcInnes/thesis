pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.additionalInfoTypeArray;
with ocpp.IdTokenEnumType; use ocpp.IdTokenEnumType;

package ocpp.IdTokenType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      additionalInfo : additionalInfoTypeArray.T;
      idToken : NonSparkTypes.IdTokenType.stridToken_t.Bounded_String;
      zzztype : IdTokenEnumType.T;
   end record;
   procedure Initialize(self: out ocpp.IdTokenType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.IdTokenType.T;
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
end ocpp.IdTokenType;
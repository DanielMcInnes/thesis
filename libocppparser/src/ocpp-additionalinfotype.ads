pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with AdditionalInfoTypestrings;

package ocpp.AdditionalInfoType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      additionalIdToken : AdditionalInfoTypeStrings.stradditionalIdToken_t.Bounded_String;
      zzztype : AdditionalInfoTypeStrings.strtype_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.AdditionalInfoType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.AdditionalInfoType.T;
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
end ocpp.AdditionalInfoType;
pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.MessageFormatEnumType; use ocpp.MessageFormatEnumType;

package ocpp.MessageContentType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      format : MessageFormatEnumType.T;
      language : NonSparkTypes.MessageContentType.strlanguage_t.Bounded_String;
      content : NonSparkTypes.MessageContentType.strcontent_t.Bounded_String;
   end record;
   procedure Initialize(self: out ocpp.MessageContentType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.MessageContentType.T;
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
end ocpp.MessageContentType;
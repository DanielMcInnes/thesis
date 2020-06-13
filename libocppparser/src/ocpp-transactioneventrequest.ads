pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with TransactionEventRequeststrings;
with ocpp.meterValueTypeArray;
with ocpp.TransactionEventEnumType; use ocpp.TransactionEventEnumType;
with ocpp.TriggerReasonEnumType; use ocpp.TriggerReasonEnumType;
with ocpp.TransactionType; use ocpp.TransactionType;
with ocpp.EVSEType; use ocpp.EVSEType;
with ocpp.IdTokenType; use ocpp.IdTokenType;

package ocpp.TransactionEventRequest is
   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("TransactionEvent"); 
   type T is new call with record
      eventType : TransactionEventEnumType.T;
      meterValue : meterValueTypeArray.T;
      timestamp : TransactionEventRequestStrings.strtimestamp_t.Bounded_String;
      triggerReason : TriggerReasonEnumType.T;
      seqNo : integer;
      offline : boolean;
      numberOfPhasesUsed : integer;
      cableMaxCurrent : Integer;
      reservationId : integer;
      transactionInfo : TransactionType.T;
      evse : EVSEType.T;
      idToken : IdTokenType.T;
   end record;
   procedure Initialize(self: out ocpp.TransactionEventRequest.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  out Integer;
                self: out ocpp.TransactionEventRequest.T;
                valid: out Boolean
               )
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (
                valid => (msg),
                msgindex => (msg),
                self  => (msg)
),
    post => (if valid = true then
               (self.messagetypeid = 2) and
               (NonSparkTypes.messageid_t.Length(self.messageid) > 0) and
               (self.action = action) -- prove that the original packet contains the corresponding "action"
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String)
      with
 Global => null,
 Annotate => (GNATprove, Terminating);
end ocpp.TransactionEventRequest;
pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with TransactionTypestrings;
with ocpp.ChargingStateEnumType; use ocpp.ChargingStateEnumType;
with ocpp.ReasonEnumType; use ocpp.ReasonEnumType;

package ocpp.TransactionType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      transactionId : TransactionTypeStrings.strtransactionId_t.Bounded_String;
      chargingState : ChargingStateEnumType.T;
      timeSpentCharging : integer;
      stoppedReason : ReasonEnumType.T;
      remoteStartId : integer;
   end record;
   procedure Initialize(self: out ocpp.TransactionType.T)
   with
    Global => null,
    Annotate => (GNATprove, Terminating),
    Depends => (self => null);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.TransactionType.T;
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
end ocpp.TransactionType;
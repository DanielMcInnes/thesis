pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.DataEnumType; use ocpp.DataEnumType;

package ocpp.VariableCharacteristicsType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      unit : NonSparkTypes.VariableCharacteristicsType.strunit_t.Bounded_String;
      dataType : DataEnumType.T;
      minLimit : Integer;
      maxLimit : Integer;
      valuesList : NonSparkTypes.VariableCharacteristicsType.strvaluesList_t.Bounded_String;
      supportsMonitoring : boolean;
   end record;
   procedure Initialize(self: out ocpp.VariableCharacteristicsType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.VariableCharacteristicsType.T;
                valid: out Boolean
               )
   with
    Global => null,
    Depends => (
                valid => (msg, msgindex),
                msgindex => (msg, msgindex),
                self  => (msg, msgindex)
            );

   procedure To_Bounded_String(Self: in T;
                               retval: out NonSparkTypes.packet.Bounded_String);
end ocpp.VariableCharacteristicsType;
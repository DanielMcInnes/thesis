pragma SPARK_mode (on); 

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with NonSparkTypes; use NonSparkTypes.action_t; 
with ocpp; use ocpp;
with ocpp.variableAttributeTypeArray;
with ocpp.ComponentType; use ocpp.ComponentType;
with ocpp.VariableType; use ocpp.VariableType;
with ocpp.VariableCharacteristicsType; use ocpp.VariableCharacteristicsType;

package ocpp.ReportDataType is
   type T is record
      zzzArrayElementInitialized : Boolean := False;
      component : ComponentType.T;
      variable : VariableType.T;
      variableAttribute : variableAttributeTypeArray.T;
      variableCharacteristics : VariableCharacteristicsType.T;
   end record;
   procedure Initialize(self: out ocpp.ReportDataType.T);

   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                msgindex:  in out Integer;
                self: out ocpp.ReportDataType.T;
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
end ocpp.ReportDataType;
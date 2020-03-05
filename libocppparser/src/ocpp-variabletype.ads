pragma SPARK_Mode (On);

with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with NonSparkTypes;

package ocpp.VariableType is

   type Class is tagged record
      name: NonSparkTypes.VariableType_t.name.Bounded_String;--Required. Name of the variable. Name should be taken from the list of standardized variable names whenever possible. Case Insensitive. strongly advised to use Camel Case.
      instance: NonSparkTypes.VariableType_t.instance.Bounded_String; -- Optional. Name of instance in case the variable exists as multiple instances. Case Insensitive. strongly advised to use Camel Case.
   end record;
   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   self: out VariableType.Class;
                   valid: out Boolean
                  )
        with
          Global => null;

   
end ocpp.VariableType;

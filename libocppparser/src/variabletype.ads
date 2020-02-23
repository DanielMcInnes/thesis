pragma SPARK_Mode (On);

with NonSparkTypes;

package VariableType is

   type Class is tagged record
      name: NonSparkTypes.variableType_t.name.Bounded_String;
      instance: NonSparkTypes.variableType_t.instance.Bounded_String;
   end record;
   
end VariableType;

with ada.Strings; use Ada.Strings;
with NonSparkTypes;
with ocpp.GetVariableResultType; -- TODO

package ocpp.GetVariableResultTypeArray is

   type Index is range 1 .. 100;
   type array_GetVariableResultType is array (Index) of ocpp.GetVariableResultType.T;
   type T is record
      content : array_GetVariableResultType;
   end record;
   
   
   procedure FromString(msg: in string;
                        self: out T;
                       valid: out Boolean);

   procedure ToString(msg: out NonSparkTypes.packet.Bounded_String;
                        self: in T);

   

end ocpp.GetVariableResultTypeArray;

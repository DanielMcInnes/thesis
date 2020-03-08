with Ada.Strings.Bounded;

package ocpp.GetVariableStatusEnumType is

   -- GetVariableStatusEnumType is used by: getVariables:GetVariablesResponse.GetVariableResultType
   type T is (Invalid,
              Accepted, 
              Rejected, 
              UnknownComponent);
      

   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 16);
   procedure FromString(str : in String;
                        attribute : out T;
                        valid : out Boolean);

   procedure ToString(attribute : in T;
                      str : out string_t.Bounded_String);


end ocpp.GetVariableStatusEnumType;

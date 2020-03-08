with Ada.Strings.Bounded;

package ocpp.AttributeEnumType is

   --AttributeEnumType is used by: Common:VariableAttributeType , getVariables:GetVariablesRequest.GetVariableDataType ,
   -- getVariables:GetVariablesResponse.GetVariableResultType , setVariables:SetVariablesRequest.SetVariableDataType ,
   --setVariables:SetVariablesResponse.SetVariableResultType
      type T is (Invalid, 
                 Actual, 
                 Target, 
                 MinSet, 
                 MaxSet);
      
      package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 7);

      procedure FromString(str : in String;
                           attribute : out T;
                           valid : out Boolean);

      procedure ToString(attribute : in T;
                         str : out string_t.Bounded_String);
   

end ocpp.AttributeEnumType;

with ocpp.AttributeEnumType;

package body ocpp.AttributeEnumType is


      procedure FromString(str : in String;
                           attribute : out T;
                           valid : out Boolean)
      is
      begin
         if (NonSparkTypes.Uncased_Equals(str, "Actual")) then
            attribute := AttributeEnumType.Actual;
         elsif (NonSparkTypes.Uncased_Equals(str, "Target")) then
            attribute := AttributeEnumType.Target;
         elsif (NonSparkTypes.Uncased_Equals(str, "MinSet")) then
            attribute := AttributeEnumType.MinSet;
         elsif (NonSparkTypes.Uncased_Equals(str, "MaxSet")) then
            attribute := AttributeEnumType.MaxSet;
         else
            attribute := AttributeEnumType.Invalid;
            valid := false;
            return;
         end if;
         valid := true;
      end FromString;

      procedure ToString(attribute : in T;
                         str : out AttributeEnumType.string_t.Bounded_String)
      is
         use AttributeEnumType.string_t;
      begin
         case attribute is
            when Invalid => str := To_Bounded_String("Invalid");
            when Actual => str := To_Bounded_String("Actual");
            when Target => str := To_Bounded_String("Target");
            when MinSet => str := To_Bounded_String("MinSet");
            when MaxSet => str := To_Bounded_String("MaxSet");
         end case;

      end ToString;
   

end ocpp.AttributeEnumType;

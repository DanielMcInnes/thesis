pragma SPARK_Mode (On);
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body utils is

   procedure contains(haystack: in string_haystack;
                      needle: in string;
                      retval: out boolean)
   is
   begin
      retval := false;
      --if S1'Length >= S3'Length and then S1 (S1'First..S1'First + S3'Length - 1) = S3
      --if (Index(haystack, needle, 1) = 0) then
      if needle'length = 0 then
         return;
      end if;
      
      if haystack_length(haystack) < needle'Length then
         return;         
      end if;
      
      if Index(haystack_to_string(haystack), needle) = 0 then
         return;
      end if;
      
      pragma assert (Index(haystack_to_string(haystack), needle) /= 0);
      retval := true;
        
      return;
      
   end contains;

end utils;

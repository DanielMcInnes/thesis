pragma SPARK_Mode (On);

with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package utils is

   generic
      type string_haystack (<>) is limited private;
      --type string_needle (<>) is limited private;
      with function haystack_to_string(msg : string_haystack) return string;
      with function haystack_length (msg : string_haystack) return integer;
      --with function needle_to_string(msg : string_needle) return string;        
      --with function length (msg : string_t) return integer;
      --with function element(msg : string_t; index: Positive) return character;
   procedure contains(haystack: in string_haystack;
                      needle: in string;
                      retval: out boolean)
     with  Global => null,
     post => (if (retval = true) then (Ada.Strings.Fixed.Index (haystack_to_string(haystack), needle) /= 0));
   end utils;

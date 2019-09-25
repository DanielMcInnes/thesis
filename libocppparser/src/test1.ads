package test1 is

   procedure Show_Illegal_SPARK_Code is

   Dummy : Integer := 0;

   function F return Integer is
      Tmp : constant Integer := Dummy;
   begin
      Dummy := Dummy + 1;
      return Tmp;
   end F;

begin
   Dummy := F - F; -- ??
end Show_Illegal_SPARK_Code;

end test1;

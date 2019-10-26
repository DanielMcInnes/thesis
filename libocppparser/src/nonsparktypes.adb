package body NonSparkTypes is
   procedure put(msg : string)
   is
   begin
      ada.Text_IO.put(msg);
   end put;

   procedure put_line(msg : string)
   is
   begin
      ada.Text_IO.put_line(msg);
   end put_line;

end NonSparkTypes;

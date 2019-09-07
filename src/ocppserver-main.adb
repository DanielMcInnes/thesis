with AWS.Config.Set;
with AWS.Net.WebSocket.Registry;

with AWS.Net.WebSocket.Registry.Control;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
with AWS.Templates;
with OCPPServer.Dispatchers;
with AWS.Net.WebSocket;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO;use Ada.Text_IO;

with OCPP;

procedure OCPPServer.Main is
   use AWS;
   use Ada.Text_IO;

   recipient          : Net.WebSocket.Registry.Recipient := Net.WebSocket.Registry.Create (URI => urlPrefix);
   httpServer         : Server.HTTP;
   awsConfig          : AWS.Config.Object;

   M : String (1 .. 255);
   L : Natural;

begin
   Put_line("starting: " & OCPPServer.Host & "/" & OCPPServer.urlPrefix & ":" & OCPPServer.Port'Image );

   --  Setup server
   Config.Set.Reuse_Address(awsConfig, True); -- if we don't do this, we have to wait a minute or so after stopping the application to restart it to avoid 'port already in use' errors.
   Config.Set.Server_Host (awsConfig, OCPPServer.Host);
   Config.Set.Server_Port (awsConfig, OCPPServer.Port);

   --  Start the server
   Net.WebSocket.Registry.Register(urlPrefix, OCPP.Create'Access);
   Net.WebSocket.Registry.Control.Start; -- starts the websocket servers
   Put_Line("ws servers started");

   Server.Start (httpServer, config => awsConfig, Callback => OCPP.HW_CB'Access);
   Put_Line("server started");
   for K in M'Range loop
      M (K) := Character'Val ((Character'Pos ('0') + K mod 10));
   end loop;

   --  Wait for at least a WebSocket to be created, no need to send a
   --  message into the void.

   while not OCPP.Created loop
      delay 1.0;
   end loop;

   --  First send a large message (message with length > 125, see RFC 6455)

   Net.WebSocket.Registry.Send (recipient, "Large message:" & M & ':');

   delay 1.0;

   --  Then send some messages

   for K in 1 .. 5 loop
      Net.WebSocket.Registry.Send (recipient, "My reply " & K'Img);
      delay 1.0;
   end loop;

   --  Get a message from user

   Ada.Text_IO.Put ("Enter a message: ");
   Ada.Text_IO.Get_Line (M, L);

   --  Finally return an XML actions document. The format of this document
   --  is identical to the one used by the Ajax framework.

   Net.WebSocket.Registry.Send
     (recipient,
      String'(AWS.Templates.Parse
        ("resp.xml", (1 => Templates.ASSOC ("MESSAGE", M (M'First .. L))))));

   Ada.Text_IO.Put_Line ("You can now press Q to exit.");

   Server.Wait (Server.Q_Key_Pressed);

   --  Now shuthdown the servers (HTTP and WebClient)

   Server.Shutdown (httpServer);

end OCPPServer.Main;



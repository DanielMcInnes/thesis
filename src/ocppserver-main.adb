with AWS.Config.Set;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
with OCPPServer.Dispatchers;
with OCPPServer.Dispatchers;
with AWS.Net.WebSocket;
with Ada.Text_IO;use Ada.Text_IO;

with OCPPWebsocket;

procedure OCPPServer.Main is
   use AWS;

   webServer         : Server.HTTP;
   webConfig         : Config.Object;

   webDispatcher      : Services.Dispatchers.URI.Handler;
   defaultDispatcher  : Dispatchers.Default;
   cssDispatcher     : Dispatchers.CSS;
   imageDispatcher   : Dispatchers.Image;
   -- ocpp_websocket     : OCPPWebsocket.MySocket;

begin
      Put("main");
   --  Setup server

   Config.Set.Server_Host (webConfig, Host);
   Config.Set.Server_Port (webConfig, Port);
   Config.Set.Reuse_Address(webConfig, True); -- if we don't do this, we have to wait a minute or so after stopping the application to restart it to avoid 'port already in use' errors.

   --  Setup dispatchers

   Dispatchers.Initialize (webConfig);

   Services.Dispatchers.URI.Register
     (webDispatcher,
      URI    => "/css",
      Action => cssDispatcher,
      Prefix => True);

   Services.Dispatchers.URI.Register
     (webDispatcher,
      URI    => "/img",
      Action => imageDispatcher,
      Prefix => True);

   Services.Dispatchers.URI.Register_Default_Callback
     (webDispatcher,
      Action => defaultDispatcher);

   --  Start the server

   Server.Start (webServer, webDispatcher, webConfig);





   --  Wait for the Q key

   Server.Wait (Server.Q_Key_Pressed);

   --  Stop the server

   Server.Shutdown (webServer);
end OCPPServer.Main;



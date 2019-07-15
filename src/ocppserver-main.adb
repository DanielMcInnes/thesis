
with AWS.Config.Set;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
with OCPPServer.Dispatchers;
with OCPPServer.Dispatchers;
with AWS.Net.WebSocket;

with OCPPWebsocket;

procedure OCPPServer.Main is
   use AWS;

   Web_Server         : Server.HTTP;
   Web_Config         : Config.Object;
   Web_Dispatcher     : Services.Dispatchers.URI.Handler;

   Default_Dispatcher : Dispatchers.Default;
   CSS_Dispatcher     : Dispatchers.CSS;
   Image_Dispatcher   : Dispatchers.Image;
   ocpp_websocket     : OCPPWebsocket.MySocket;



begin



   --  Setup server

   Config.Set.Server_Host (Web_Config, Host);
   Config.Set.Server_Port (Web_Config, Port);
   Config.Set.Reuse_Address(Web_Config, True); -- if we don't do this, we have to wait a minute or so after stopping the application to restart it to avoid 'port already in use' errors.

   --  Setup dispatchers

   Dispatchers.Initialize (Web_Config);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher,
      URI    => "/css",
      Action => CSS_Dispatcher,
      Prefix => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher,
      URI    => "/img",
      Action => Image_Dispatcher,
      Prefix => True);

   Services.Dispatchers.URI.Register_Default_Callback
     (Web_Dispatcher,
      Action => Default_Dispatcher);

   --  Start the server

   Server.Start (Web_Server, Web_Dispatcher, Web_Config);





   --  Wait for the Q key

   Server.Wait (Server.Q_Key_Pressed);

   --  Stop the server

   Server.Shutdown (Web_Server);
end OCPPServer.Main;



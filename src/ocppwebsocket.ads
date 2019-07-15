with AWS.Config.Set;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
--with Default.Dispatchers;
with AWS.Net.WebSocket;
with AWS.Net;
with AWS.Status;

package OCPPWebsocket is
   type MySocket is new AWS.Net.WebSocket.Object with null record;

   function Create(Socket :  AWS.Net.Socket_Access;
                   Request : AWS.Status.Data) return AWS.Net.WebSocket.Object'Class;

end OCPPWebsocket;

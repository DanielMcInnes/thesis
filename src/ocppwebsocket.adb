with AWS.Config.Set;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
--with Default.Dispatchers;
with AWS.Net; use AWS.Net;
with AWS.Net.WebSocket;
with AWS.Status;
with OCPPWebsocket; use OCPPWebsocket;

package body OCPPWebsocket is
use AWS;


function Create
     (Socket  : Socket_Access;
      Request : AWS.Status.Data) return AWS.Net.WebSocket.Object'Class
is
   begin
      --  Note the call to the other version of Create*
   return MySocket'
     (AWS.Net.WebSocket.Object
        (AWS.Net.WebSocket.Create (Socket, Request)) with null record);

end Create;

end OCPPWebsocket;

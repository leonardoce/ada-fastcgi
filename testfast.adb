with Fcgiapp_H;
with Fastcgi;

procedure Testfast is
   Socket:Fastcgi.Socket_Handle;
   Request:Fastcgi.Request_Type;
   
begin
   Fastcgi.Init;
   Socket := Fastcgi.Open_Socket(":5000", 0);
   Fastcgi.Init_Request(Request, Socket);
   
   Fastcgi.Accept_Request(Request);
end;

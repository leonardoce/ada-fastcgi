with Fcgiapp_H;

package Fastcgi is
   type Socket_Handle is private;
   type Request_Type is private;
   Fastcgi_Error : exception;
   
   procedure Init;   
   function Open_Socket(Path:String; Backlog:Natural) return Socket_Handle;
   procedure Init_Request(Request:out Request_Type; Socket:Socket_Handle);
   procedure Accept_Request(Request:in out Request_Type);
private
   type Socket_Handle is new Integer;
   
   type Request_Type is new Fcgiapp_H.FCGX_Request;
end;

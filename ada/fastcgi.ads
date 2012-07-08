with Fcgiapp_H;

package Fastcgi is
   type Socket_Handle is private;
   type Request_Type is private;
   type Stream_Handle is private;
   
   Fastcgi_Error : exception;
   
   procedure Init;   
   function Open_Socket(Path:String; Backlog:Natural) return Socket_Handle;
   procedure Init_Request(Request:out Request_Type; Socket:Socket_Handle);
   procedure Accept_Request(Request:in out Request_Type);
   procedure Finish_Request(Request:in out Request_Type);
   
   function Get_In_Channel(Request:in Request_Type) return Stream_Handle;
   function Get_Out_Channel(Request:in Request_Type) return Stream_Handle;
   function Get_Err_Channel(Request:in Request_Type) return Stream_Handle;
   
   procedure Put(Str:String; Channel:Stream_Handle);
   procedure Get(Buffer:out String; Count:in out Natural; Channel:Stream_Handle);
   
private
   type Socket_Handle is new Integer;
   
   type Request_Type is new Fcgiapp_H.FCGX_Request;
   type Stream_Handle is new Fcgiapp_H.FCGX_Stream_Access;
end;

with Interfaces.C;
with Interfaces.C.Strings;
with Fcgiapp_H;

package body Fastcgi is
   procedure Init is
      Val : Interfaces.C.Int;
   begin
      Val := Fcgiapp_H.FCGX_Init;
   end;

   function Open_Socket(Path:String; Backlog:Natural) return Socket_Handle is
      use Interfaces.C.Strings;
      use Interfaces.C;
      
      C_Path : Chars_Ptr;
      Val:Interfaces.C.Int;
   begin
      C_Path := New_String(Path);
      Val := Fcgiapp_H.FCGX_OpenSocket(C_Path, Interfaces.C.Int(Backlog));
      Free(C_Path);
      
      if Val = (-1) then
	 raise Fastcgi_Error;
      end if;
      
      return Socket_Handle(Val);
   end;
   
   procedure Init_Request(Request:out Request_Type; Socket:Socket_Handle) is
      use Interfaces.C;
      Val : Interfaces.C.Int;
   begin
      Val := Fcgiapp_H.FCGX_InitRequest(Request'Address, Interfaces.C.Int(Socket), 0);
      
      if Val /= 0 then
	 raise Fastcgi_Error;
      end if;
   end;
   
   procedure Accept_Request(Request:in out Request_Type) is
      use Interfaces.C;
      Val : Interfaces.C.Int;
   begin
      Val := Fcgiapp_H.FCGX_Accept_R(Request'Address);
      
      if Val /= 0 then
	 raise Fastcgi_Error;
      end if;
   end;
   
   procedure Finish_Request(Request:in out Request_Type) is
   begin
      Fcgiapp_H.FCGX_Finish_R(Request'Address);
   end;
end;

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
   
   function Get_In_Channel(Request:in Request_Type) return Stream_Handle is
   begin
      return Stream_Handle(Request.C_In);
   end;
   
   function Get_Out_Channel(Request:in Request_Type) return Stream_Handle is
   begin
      return Stream_Handle(Request.C_Out);
   end;
   
   function Get_Err_Channel(Request:in Request_Type) return Stream_Handle is
   begin
      return Stream_Handle(Request.Err);
   end;
   
   procedure Put(Str:String; Channel:Stream_Handle) is
      use Interfaces.C.Strings;
      use Interfaces.C;
      
      C_Str : Chars_Ptr;
      Val:Interfaces.C.Int;
   begin
      C_Str := New_String(Str);
      Val := Fcgiapp_H.FCGX_PutStr(C_Str, Str'Length, Fcgiapp_H.FCGX_Stream_Access(Channel));
      Free(C_Str);
      
      if Val=(-1) then 
	 raise Fastcgi_Error;
      end if;
   end;
   
   procedure Get(Buffer:out String; Count:in out Natural; Channel:Stream_Handle) is
      use Interfaces.C.Strings;
      use Interfaces.C;
      
      Aux_Buffer : String(1..Count) := (others => ' ');
      Val : Interfaces.C.Int;
      C_Buffer : Chars_Ptr;
   begin      
      C_Buffer := New_String(Aux_Buffer);
      Val := Fcgiapp_H.FCGX_GetStr(C_Buffer, Interfaces.C.Int(Count), 
						      Fcgiapp_H.FCGX_Stream_Access(channel));
      Count := Natural(Val);
      Buffer(Buffer'first..Integer(Val)+1) := Value(C_Buffer,Size_T(Val))(1..Integer(Val)+1);
      Free(C_Buffer);
   end;
end;

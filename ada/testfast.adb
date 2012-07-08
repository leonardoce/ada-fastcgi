with Fcgiapp_H;
with Fastcgi;

procedure Testfast is
   Socket:Fastcgi.Socket_Handle;
   Request:Fastcgi.Request_Type;
   
begin
   Fastcgi.Init;
   Socket := Fastcgi.Open_Socket(":5000", 0);
   Fastcgi.Init_Request(Request, Socket);
   
   while True loop
      Fastcgi.Accept_Request(Request);
      declare
	 Out_Chan : Fastcgi.Stream_Handle := Fastcgi.Get_Out_Channel(Request);
      begin
	 Fastcgi.Put("Content-type: text/html" & Ascii.Cr & Ascii.Lf, Out_Chan);
	 Fastcgi.Put(Ascii.Cr & Ascii.Lf, Out_Chan);
	 Fastcgi.Put("<html><body>ciao", Out_Chan);
	 
	 for I in 1..1000 loop
	    Fastcgi.Put("prova<br>", Out_Chan);
	 end loop;
	 
	 Fastcgi.Put("</body></html>", Out_Chan);
      end;
   end loop;
end;

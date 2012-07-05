with Fcgiapp_H;
with Interfaces.C;

procedure Testfast is
   use Fcgiapp_H;
   
   R:Interfaces.C.Int;
begin
   R:=FCGX_Init;
end;

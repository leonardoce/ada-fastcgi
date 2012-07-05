with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Strings;

package fcgiapp_h is

   --  unsupported macro: FCGX_UNSUPPORTED_VERSION -2
   --  unsupported macro: FCGX_PROTOCOL_ERROR -3
   --  unsupported macro: FCGX_PARAMS_ERROR -4
   --  unsupported macro: FCGX_CALL_SEQ_ERROR -5
   --  unsupported macro: FCGI_FAIL_ACCEPT_ON_INTR 1
   type FCGX_Stream is record
      rdNext : access unsigned_char;  -- c/fcgiapp.h:54
      wrNext : access unsigned_char;  -- c/fcgiapp.h:56
      stop : access unsigned_char;  -- c/fcgiapp.h:58
      stopUnget : access unsigned_char;  -- c/fcgiapp.h:60
      isReader : aliased int;  -- c/fcgiapp.h:63
      isClosed : aliased int;  -- c/fcgiapp.h:64
      wasFCloseCalled : aliased int;  -- c/fcgiapp.h:65
      FCGI_errno : aliased int;  -- c/fcgiapp.h:66
      fillBuffProc : access procedure (arg1 : access FCGX_Stream);  -- c/fcgiapp.h:67
      emptyBuffProc : access procedure (arg1 : access FCGX_Stream; arg2 : int);  -- c/fcgiapp.h:68
      data : System.Address;  -- c/fcgiapp.h:69
   end record;
   pragma Convention (C_Pass_By_Copy, FCGX_Stream);  -- c/fcgiapp.h:53

   type FCGX_ParamArray is new System.Address;  -- c/fcgiapp.h:76

   type FCGX_Request is record
      requestId : aliased int;  -- c/fcgiapp.h:92
      role : aliased int;  -- c/fcgiapp.h:93
      c_in : access FCGX_Stream;  -- c/fcgiapp.h:94
      c_out : access FCGX_Stream;  -- c/fcgiapp.h:95
      err : access FCGX_Stream;  -- c/fcgiapp.h:96
      envp : System.Address;  -- c/fcgiapp.h:97
      paramsPtr : System.Address;  -- c/fcgiapp.h:101
      ipcFd : aliased int;  -- c/fcgiapp.h:102
      isBeginProcessed : aliased int;  -- c/fcgiapp.h:103
      keepConnection : aliased int;  -- c/fcgiapp.h:104
      appStatus : aliased int;  -- c/fcgiapp.h:105
      nWriters : aliased int;  -- c/fcgiapp.h:106
      flags : aliased int;  -- c/fcgiapp.h:107
      listen_sock : aliased int;  -- c/fcgiapp.h:108
   end record;
   pragma Convention (C_Pass_By_Copy, FCGX_Request);  -- c/fcgiapp.h:91

   --  skipped empty struct Params

   function FCGX_IsCGI return int;  -- c/fcgiapp.h:128
   pragma Import (C, FCGX_IsCGI, "FCGX_IsCGI");

   function FCGX_Init return int;  -- c/fcgiapp.h:142
   pragma Import (C, FCGX_Init, "FCGX_Init");

   function FCGX_OpenSocket (path : Interfaces.C.Strings.chars_ptr; backlog : int) return int;  -- c/fcgiapp.h:160
   pragma Import (C, FCGX_OpenSocket, "FCGX_OpenSocket");

   function FCGX_InitRequest
     (request : System.Address;
      sock : int;
      flags : int) return int;  -- c/fcgiapp.h:175
   pragma Import (C, FCGX_InitRequest, "FCGX_InitRequest");

   function FCGX_Accept_r (request : System.Address) return int;  -- c/fcgiapp.h:207
   pragma Import (C, FCGX_Accept_r, "FCGX_Accept_r");

   procedure FCGX_Finish_r (request : access FCGX_Request);  -- c/fcgiapp.h:228
   pragma Import (C, FCGX_Finish_r, "FCGX_Finish_r");

   procedure FCGX_Free (request : access FCGX_Request; close : int);  -- c/fcgiapp.h:240
   pragma Import (C, FCGX_Free, "FCGX_Free");

   function FCGX_Accept
     (c_in : System.Address;
      c_out : System.Address;
      err : System.Address;
      envp : System.Address) return int;  -- c/fcgiapp.h:269
   pragma Import (C, FCGX_Accept, "FCGX_Accept");

   procedure FCGX_Finish;  -- c/fcgiapp.h:294
   pragma Import (C, FCGX_Finish, "FCGX_Finish");

   function FCGX_StartFilterData (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:313
   pragma Import (C, FCGX_StartFilterData, "FCGX_StartFilterData");

   procedure FCGX_SetExitStatus (status : int; stream : access FCGX_Stream);  -- c/fcgiapp.h:328
   pragma Import (C, FCGX_SetExitStatus, "FCGX_SetExitStatus");

   function FCGX_GetParam (name : Interfaces.C.Strings.chars_ptr; envp : FCGX_ParamArray) return Interfaces.C.Strings.chars_ptr;  -- c/fcgiapp.h:349
   pragma Import (C, FCGX_GetParam, "FCGX_GetParam");

   function FCGX_GetChar (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:369
   pragma Import (C, FCGX_GetChar, "FCGX_GetChar");

   function FCGX_UnGetChar (c : int; stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:385
   pragma Import (C, FCGX_UnGetChar, "FCGX_UnGetChar");

   function FCGX_GetStr
     (str : Interfaces.C.Strings.chars_ptr;
      n : int;
      stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:402
   pragma Import (C, FCGX_GetStr, "FCGX_GetStr");

   function FCGX_GetLine
     (str : Interfaces.C.Strings.chars_ptr;
      n : int;
      stream : access FCGX_Stream) return Interfaces.C.Strings.chars_ptr;  -- c/fcgiapp.h:421
   pragma Import (C, FCGX_GetLine, "FCGX_GetLine");

   function FCGX_HasSeenEOF (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:442
   pragma Import (C, FCGX_HasSeenEOF, "FCGX_HasSeenEOF");

   function FCGX_PutChar (c : int; stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:462
   pragma Import (C, FCGX_PutChar, "FCGX_PutChar");

   function FCGX_PutStr
     (str : Interfaces.C.Strings.chars_ptr;
      n : int;
      stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:479
   pragma Import (C, FCGX_PutStr, "FCGX_PutStr");

   function FCGX_PutS (str : Interfaces.C.Strings.chars_ptr; stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:494
   pragma Import (C, FCGX_PutS, "FCGX_PutS");

   function FCGX_FPrintF (stream : access FCGX_Stream; format : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- c/fcgiapp.h:510
   pragma Import (C, FCGX_FPrintF, "FCGX_FPrintF");

   function FCGX_FFlush (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:531
   pragma Import (C, FCGX_FFlush, "FCGX_FFlush");

   function FCGX_FClose (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:557
   pragma Import (C, FCGX_FClose, "FCGX_FClose");

   function FCGX_GetError (stream : access FCGX_Stream) return int;  -- c/fcgiapp.h:569
   pragma Import (C, FCGX_GetError, "FCGX_GetError");

   procedure FCGX_ClearError (stream : access FCGX_Stream);  -- c/fcgiapp.h:580
   pragma Import (C, FCGX_ClearError, "FCGX_ClearError");

   function FCGX_CreateWriter
     (socket : int;
      requestId : int;
      bufflen : int;
      streamType : int) return access FCGX_Stream;  -- c/fcgiapp.h:592
   pragma Import (C, FCGX_CreateWriter, "FCGX_CreateWriter");

   procedure FCGX_FreeStream (stream : System.Address);  -- c/fcgiapp.h:608
   pragma Import (C, FCGX_FreeStream, "FCGX_FreeStream");

   procedure FCGX_ShutdownPending;  -- c/fcgiapp.h:616
   pragma Import (C, FCGX_ShutdownPending, "FCGX_ShutdownPending");

end fcgiapp_h;

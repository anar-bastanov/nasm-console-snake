%ifndef __STDCALL_INC
%define __STDCALL_INC

extern __stdcall

%macro stdcall 1
    lea r15, [rel %1]
    call __stdcall
%endmacro

%endif

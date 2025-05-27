%ifndef __CALLCLIB_INC__
%define __CALLCLIB_INC__

extern __callclib

%macro callclib 1
    lea r15, [rel %1]
    call __callclib
%endmacro

%endif

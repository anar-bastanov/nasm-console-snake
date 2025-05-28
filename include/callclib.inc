%ifndef __CALLCLIB_INC__
%define __CALLCLIB_INC__

%include "callclib_argc.inc"

%assign i 0
%rep CALLCLIB_MAX_ARG_COUNT + 1
    extern __callclib%[i]
%assign i i + 1
%endrep

%macro callclib 2
    %if %1 >= 0 && %1 <= CALLCLIB_MAX_ARG_COUNT
    %else
        %error Invalid number of function parameters.
    %endif

    lea r15, [rel %2]
    call __callclib%1
%endmacro

%macro callclib 1
    lea r15, [rel %1]
    call __callclib0
%endmacro

%endif

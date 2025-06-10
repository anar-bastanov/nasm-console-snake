%include "anrc/_callclib_argc.internal.inc"

%define NON_NEGATIVE(value) %cond(value < 0, 0, value)

%ifdef WINDOWS
    %macro PRESERVATION 0
        push r14
        mov r14, rsp
        sub rsp, 6 * 8
        mov [rsp + 40], r11
        mov [rsp + 32], r10
        mov [rsp + 24], r9
        mov [rsp + 16], r8
        mov [rsp +  8], rcx
        mov [rsp +  0], rdx
    %endmacro
    %macro INITIALIZATION 1
        %if %1 >= 5
            sub rsp, 8 * (%1 - 5 + 1)
        %endif
        and rsp, -16
        %if %1 >= 1
            mov rcx, r8
        %endif
        %if %1 >= 2
            mov rdx, r9
        %endif
        %if %1 >= 3
            mov r8,  r10
        %endif
        %if %1 >= 4
            mov r9,  r11
        %endif
        %if %1 >= 5
            mov [rsp + 0], r12
        %endif
        %if %1 >= 6
            mov [rsp + 8], r13
        %endif
        %assign j 0
        %rep NON_NEGATIVE(%1 - 7 + 1)
            mov rax, [r14 + 8 + 8 + j * 8]
            mov [rsp + (j + 2) * 8], rax
            %assign j j + 1
        %endrep
        sub rsp, 32
    %endmacro
    %macro RESTORATION 0
        mov rsp, r14
        mov r11, [rsp -  8]
        mov r10, [rsp - 16]
        mov r9,  [rsp - 24]
        mov r8,  [rsp - 32]
        mov rcx, [rsp - 40]
        mov rdx, [rsp - 48]
        pop r14
    %endmacro
%elifdef LINUX
    %macro PRESERVATION 0
        push r14
        mov r14, rsp
        sub rsp, 8 * 8
        mov [rsp + 56], r11
        mov [rsp + 48], r10
        mov [rsp + 40], r9
        mov [rsp + 32], r8
        mov [rsp + 24], rsi
        mov [rsp + 16], rdi
        mov [rsp +  8], rcx
        mov [rsp +  0], rdx
    %endmacro
    %macro INITIALIZATION 1
        %if %1 >= 7
            sub rsp, 8 * (%1 - 7 + 1)
        %endif
        and rsp, -16
        %if %1 >= 1
            mov rdi, r8
        %endif
        %if %1 >= 2
            mov rsi, r9
        %endif
        %if %1 >= 3
            mov rdx, r10
        %endif
        %if %1 >= 4
            mov rcx, r11
        %endif
        %if %1 >= 5
            mov r8,  r12
        %endif
        %if %1 >= 6
            mov r9,  r13
        %endif
        %assign j 0
        %rep NON_NEGATIVE(%1 - 7 + 1)
            mov rax, [r14 + 8 + 8 + j * 8]
            mov [rsp + j * 8], rax
            %assign j j + 1
        %endrep
    %endmacro
    %macro RESTORATION 0
        mov rsp, r14
        mov r11, [rsp -  8]
        mov r10, [rsp - 16]
        mov r9 , [rsp - 24]
        mov r8 , [rsp - 32]
        mov rsi, [rsp - 40]
        mov rdi, [rsp - 48]
        mov rcx, [rsp - 56]
        mov rdx, [rsp - 64]
        pop r14
    %endmacro
%else
    %fatal Neither WINDOWS nor LINUX was defined.
%endif

%macro __callclib_var 1
    %if %isnnum(%1) || %1 < 0 || %1 > CALLCLIB_MAX_ARG_COUNT
        %fatal Invalid number of function parameters.
    %endif

    global __callclib%1

    __callclib%1:
        PRESERVATION
        INITIALIZATION %1
        call r15
        RESTORATION
        ret
%endmacro

section .text

%assign i 0
%rep CALLCLIB_MAX_ARG_COUNT + 1
    __callclib_var i
    %assign i i + 1
%endrep

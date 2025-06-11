global _args_collect
global args_count
global args_get

%ifdef WINDOWS
    %define argc_reg rcx
    %define argv_reg rdx
%elifdef LINUX
    %define argc_reg rdi
    %define argv_reg rsi
%else
    %fatal Neither WINDOWS nor LINUX was defined.
%endif

section .bss

argc:
    resq 1

argv:
    resq 1

section .text

_args_collect:
    mov [rel argv], argv_reg
    mov [rel argc], argc_reg
    ret

args_count:
    mov eax, [rel argc]
    ret

args_get:
    mov rax, [rel argv]
    mov rax, [rax + r8 * 8]
    ret

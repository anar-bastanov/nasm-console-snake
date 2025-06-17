%include "strutils/all"
%include "argparse/args_container.inc"

global _args_collect_from_main
global args_initialize
global args_parse_next

%ifdef WINDOWS
    %define argc_reg rcx
    %define argv_reg rdx
%elifdef LINUX
    %define argc_reg rdi
    %define argv_reg rsi
%else
    %fatal Neither WINDOWS nor LINUX was defined.
%endif

section .text

_args_collect_from_main:
    mov [r8 + args_container_t.argv], argv_reg
    mov [r8 + args_container_t.argc], argc_reg
    ret

args_initialize:
    mov [r8 + args_container_t.options_list], r9
    mov dword [r8 + args_container_t.index], 1
    ret

args_parse_next:
    mov edx, 1
    xadd [r8 + args_container_t.index], edx
    cmp edx, [r8 + args_container_t.argc]
    jae .end_of_argv

    ; loop through `options_list` and match the value of `argv` at `index`

.end_of_argv:
    xor eax, eax
    ret

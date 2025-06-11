%include "anrc/callclib.inc"
%include "include/qrgen.inc"
%include "include/static_strings.inc"

global program_entry

extern program_exit_early

section .rodata

test_err_msg_str:
    db "An unexpected error occured!", 10, 0

section .text

program_entry:
    call env_init
    call func

    xor eax, eax
    ret

env_init:
    push r8
    push r9

    mov r8d, [cc_LC_ALL]
    mov r9, utf8_locale_str
    callclib 2, setlocale

    pop r9
    pop r8
    ret

func:
    push r8

    mov r8, test_str
    mov r9d, 4
    mov r10d, 26
    callclib 3, printf
    ; callclib getchar

    mov r8d, 1
    lea r9, [rel test_err_msg_str]
    call program_exit_early

    pop r8
    ret

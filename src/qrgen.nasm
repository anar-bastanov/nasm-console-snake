%include "anrc/callclib.inc"
%include "include/qrgen.inc"
%include "include/static_strings.inc"

global program

section .data

section .text

program:
    call env_init
    call game_init

    mov r9d, 5

    .loop:
        call game_loop

        dec r9d
        jg .loop

    call game_exit

    xor eax, eax
    ret

env_init:
    push r8
    push r9

    mov r8d, [c_LC_ALL]
    mov r9, utf8_locale_str
    callclib 2, setlocale

    pop r9
    pop r8
    ret

game_init:
    push r8

    mov r8, test_str
    mov r9d, 4
    mov r10d, 26
    callclib 3, printf

    pop r8
    ret

game_exit:
    ret

game_loop:
    mov al, 1
    ret

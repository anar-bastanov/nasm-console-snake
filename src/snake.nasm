%include "callclib.inc"
%include "snake.inc"

global program

section .data

test_str:
    db "╔═╗", 10
    db "║█║", 10
    db "╚═╝", 10, 0

utf8_locale_str:
    db ".UTF8", 0

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

    xor r8d, r8d
    mov r9, utf8_locale_str
    callclib 2, setlocale

    pop r9
    pop r8
    ret

game_init:
    push r8

    mov r8, test_str
    callclib 1, printf

    pop r8
    ret

game_exit:
    ret

game_loop:
    mov al, 1
    ret

%include "callclib.inc"
%include "snake.inc"

global program

section .data

test_str:
    db "Hello %i %i.", 10, 0

test_wtr:
    dw "G", "o", "o", "d", "b", "y", "e", 10, 0

section .text

program:
    push r8
    push r9
    push r10

    call game_init

    mov r9d, 5

.loop:
    call game_loop

    dec r9d
    jg .loop

    call game_exit

    mov r8, test_str
    mov r9, 69
    mov r10, 420
    callclib 3, printf

    mov r8, test_wtr
    callclib 1, wprintf

    pop r10
    pop r9
    pop r8
    xor eax, eax
    ret

game_init:
    ret

game_exit:
    ret

game_loop:
    mov al, 1
    ret

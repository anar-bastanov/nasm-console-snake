%include "callclib.inc"

global program

extern printf

section .data

init_str:
    db "Hello %i!", 10, 0

loop_str:
    db "Looping %i...", 10, 0

bye_str:
    db "Goodbye %i and %i!", 10, 0

section .text

program:
    push r8
    push r9
    push r10

    call game_init

    mov r8, init_str
    mov r9d, 12
    callclib printf

    mov r9d, 5

.loop:
    call game_loop

    mov r8, loop_str
    callclib printf
    
    dec r9d
    jg .loop

    call game_exit

    mov r8, bye_str
    mov r9d, 26
    mov r10d, 2612
    callclib printf

    pop r10
    pop r9
    pop r8
    mov eax, 126
    ret

game_init:
    ret

game_exit:
    ret

game_loop:
    mov al, 1
    ret

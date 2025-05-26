%include "stdcall.inc"

global program

section .text

program:
    call game_init

.loop:
    call game_loop
    test al, al
    jz .loop

    call game_exit
    mov eax, 126
    ret

game_init:
    ret

game_exit:
    ret

game_loop:
    mov al, 1
    ret

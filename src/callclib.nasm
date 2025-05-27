global __callclib

section .text

__callclib:
%ifdef WINDOWS
    push r14
    mov r14, rsp

    sub rsp, 6 * 8
    mov [rsp + 40], r11
    mov [rsp + 32], r10
    mov [rsp + 24], r9
    mov [rsp + 16], r8
    mov [rsp +  8], rcx
    mov [rsp +  0], rdx

    and rsp, -16
    mov rcx, r8
    mov rdx, r9
    mov r8,  r10
    mov r9,  r11
    push r13
    push r12
    sub rsp, 32

    call r15

    mov rsp, r14
    mov r11, [rsp -  8]
    mov r10, [rsp - 16]
    mov r9,  [rsp - 24]
    mov r8,  [rsp - 32]
    mov rcx, [rsp - 40]
    mov rdx, [rsp - 48]

    pop r14
    ret
%elifdef LINUX
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

    and rsp, -16
    mov rdi, r8
    mov rsi, r9
    mov rdx, r10
    mov rcx, r11
    mov r8,  r10
    mov r9,  r11

    call r15

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
    ret
%else
    %error Neither WINDOWS nor LINUX was defined.
%endif

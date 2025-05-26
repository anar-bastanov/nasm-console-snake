global __stdcall

section .text

__stdcall:
%ifdef WINDOWS
    sub rsp, 8 * 8
    mov [rsp + 56], r11
    mov [rsp + 48], r10
    mov [rsp + 40], r9
    mov [rsp + 32], r8
    mov [rsp + 24], rcx
    mov [rsp + 16], rdx

    mov [rsp + 8], rsp
    mov [rsp + 0], rsp
    and rsp, -16

    push r9
    push r8
    mov r9, rcx
    mov r8, rdx
    mov rdx, rsi
    mov rcx, rdi

    sub rsp, 32
    call r15
    add rsp, 32 + 2 * 8

    mov rsp, [rsp + 8]

    mov rdx, [rsp + 16]
    mov rcx, [rsp + 24]
    mov r8,  [rsp + 32]
    mov r9,  [rsp + 40]
    mov r10, [rsp + 48]
    mov r11, [rsp + 56]
    add rsp, 8 * 8
    ret
%elifdef LINUX
    ; TODO: Add Linux compatible convention
    call r15
    ret
%else
    %error Neither WINDOWS nor LINUX was defined.
%endif

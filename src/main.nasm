%include "anrc/callclib.inc"

global main

extern program

section .rodata

program_exit_str:
    db 10, "The process exited with code %i (0x%x).", 10, "Press Enter to close this window . . .", 0

section .text

main:
    push rbx
    push rdi
    push rsi
    push r12
    push r13
    push r14
    push r15

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    xor r8d, r8d
    xor r9d, r9d
    xor r10d, r10d
    xor r11d, r11d
    xor r12d, r12d
    xor r13d, r14d
    xor r14d, r14d
    xor r15d, r15d

    call program

    mov r8, program_exit_str
    mov r9d, eax
    mov r10d, eax
    callclib 3, printf
    callclib getchar

    mov eax, r9d
    pop r15
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rdi
    pop rbx
    ret

%include "anrc/callclib.inc"
%include "argparse/parser.inc"

global main
global program_exit_early

extern program_entry

section .bss

program_stack_pointer resq 1

section .text

main:
    call _args_collect

    push rbx
    push rdi
    push rsi
    push r12
    push r13
    push r14
    push r15
    mov [rel program_stack_pointer], rsp

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
    call program_entry

.restore_stack:
    mov rsp, [rel program_stack_pointer]
    pop r15
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rdi
    pop rbx
    ret

program_exit_early:
    test r8d, r8d
    mov eax, r8d
    jz main.restore_stack

    test r9, r9
    mov r10d, eax
    jz main.restore_stack

    mov r8, r9
    mov r9, [rel cc_stderr]
    callclib 2, fputs

    mov eax, r10d
    jmp main.restore_stack

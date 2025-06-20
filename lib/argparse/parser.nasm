%include "strutils/all"
%include "argparse/args_container.inc"

global _args_collect_from_main
global args_initialize
global args_reset
global args_parse_next

%ifdef WINDOWS
    %define argc_reg rcx
    %define argv_reg rdx
%elifdef LINUX
    %define argc_reg rdi
    %define argv_reg rsi
%else
    %fatal Neither WINDOWS nor LINUX was defined.
%endif

section .text

_args_collect_from_main:
    mov [r8 + args_container_t.argv], argv_reg
    mov [r8 + args_container_t.argc], argc_reg
    ret

args_initialize:
    mov [r8 + args_container_t.options_list], r9
    mov [r8 + args_container_t.options_list_count], r10d
    mov dword [r8 + args_container_t.index], 1
    ret

args_reset:
    mov dword [r8 + args_container_t.index], 1
    ret

args_parse_next:
    push r8
    push r9
    push r10  ; option
    push r11  ; argv start
    push r12  ; argv end
    push r13  ; container

    mov r13, r8
    xor eax, eax
    mov r12d, [r13 + args_container_t.index]
    cmp r12d, [r13 + args_container_t.argc]
    jnb .return

    mov r11d, r12d
    xor r10d, r10d

    .loop_find_option_begin:
        mov rax, [r13 + args_container_t.argv]
        mov rax, [rax + r12 * 8]

        mov cl, [rax]
        cmp cl, '-'
        je .is_option

        test r10d, r10d
        lea r12d, [r12d + 1]
        jz .loop_find_option_end
        jmp .advance_index

    .is_option:
        test r10d, r10d
        jnz .loop_find_option_end

        inc r12d    
        mov r8, [r13 + args_container_t.argv]
        mov r8, [r8 + r11 * 8]

        .loop_match_option_begin:
            cmp r10d, [r13 + args_container_t.options_list_count]
            jnb .loop_match_option_end

            inc r10d
            mov r9, [r13 + args_container_t.options_list]
            mov r9, [r9 + r10 * 8]
            add r9, 8
            call string_compare
            jne .loop_match_option_begin
        .loop_match_option_end:

    .advance_index:
        cmp r12d, [r13 + args_container_t.argc]
        jb .loop_find_option_begin
    .loop_find_option_end:

    mov rax, [r13 + args_container_t.options_list]
    mov rax, [rax + r10 * 8]
    mov r8, [r13 + args_container_t.argv]
    lea r8, [r8 + r11 * 8]
    mov r9d, r12d
    sub r9d, r11d
    call [rax]

    mov [r13 + args_container_t.index], r12d
    mov eax, 1

.return:
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    ret

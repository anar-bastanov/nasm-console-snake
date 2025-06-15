global string_size
global string_n_size
global string_length
global string_n_length

section .text

string_size:
    xor eax, eax

    .loop:
        cmp byte [r8 + rax], 0
        lea eax, [eax + 1]
        jne .loop

    ret

string_n_size:
    xor eax, eax

    .loop_begin:
        cmp eax, r9d
        jnb .loop_end

        cmp byte [r8 + rax], 0
        lea eax, [eax + 1]
        jne .loop_begin
    .loop_end:

    ret

string_length:
    xor eax, eax

    .loop_begin:
        cmp byte [r8 + rax], 0
        je .loop_end

        inc eax
        jmp .loop_begin
    .loop_end:

    ret

string_n_length:
    xor eax, eax

    .loop_begin:
        cmp eax, r9d
        jnb .loop_end

        cmp byte [r8 + rax], 0
        je .loop_end

        inc eax
        jmp .loop_begin
    .loop_end:

    ret

%if 0
string_size:
    mov rdi, r8
    xor eax, eax
    mov ecx, -1
    cld
    repne scasb
    not ecx
    mov eax, ecx
    ret

string_length:
    mov rdi, r8
    xor eax, eax
    mov ecx, -1
    cld
    repne scasb
    not ecx
    lea eax, [ecx - 1]
    ret
%endif

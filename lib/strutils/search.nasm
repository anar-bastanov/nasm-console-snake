global string_find_char
global string_n_find_char
global string_find_char_last
global string_n_find_char_last

section .text.strutils.search

string_find_char:
    mov rax, r8

    .loop_begin:
        mov bl, [rax]
        cmp bl, r9b
        je .loop_end

        add bl, 0xFF
        lea rax, [rax + 1]
        jc .loop_begin

    .not_found:
        mov eax, 0
        ret
    .loop_end:

    ret

string_n_find_char:
    mov ecx, r10d
    mov rax, r8

    .loop_begin:
        dec ecx
        js .not_found

        mov bl, [rax]
        cmp bl, r9b
        je .loop_end

        add bl, 0xFF
        lea rax, [rax + 1]
        jc .loop_begin

    .not_found:
        mov eax, 0
        ret
    .loop_end:

    ret

string_find_char_last:
    mov rdx, r8
    xor eax, eax

    .loop:
        mov bl, [rdx]
        cmp bl, r9b
        cmove rax, rdx

        test bl, bl
        lea rdx, [rdx + 1]
        jne .loop

    ret

string_n_find_char_last:
    mov ecx, r10d
    mov rdx, r8
    xor eax, eax

    .loop:
        dec ecx
        js .not_found

        mov bl, [rdx]
        cmp bl, r9b
        cmove rax, rdx

        test bl, bl
        lea rdx, [rdx + 1]
        jne .loop

.not_found:
    ret

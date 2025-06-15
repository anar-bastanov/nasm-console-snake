global string_compare
global string_n_compare
global string_compare_normalized
global string_n_compare_normalized

section .text

string_compare:
    xor edx, edx

    .loop_begin:
        mov al, [r8 + rdx]
        mov bl, [r9 + rdx]
        inc edx
        sub al, bl
        jnz .loop_end

        test bl, bl
        jnz .loop_begin
    .loop_end:

    movsx eax, al
    ret

string_n_compare:
    xor edx, edx
    xor eax, eax

    .loop_begin:
        cmp edx, r10d
        jnb .out_of_bounds

        mov al, [r8 + rdx]
        mov bl, [r9 + rdx]
        inc edx
        sub al, bl
        jnz .loop_end

        test bl, bl
        jnz .loop_begin
    .loop_end:

    movsx eax, al
.out_of_bounds:
    ret

string_compare_normalized:
    xor edx, edx

    .loop_begin:
        mov al, [r8 + rdx]
        mov bl, [r9 + rdx]
        inc edx
        sub al, bl
        jnz .loop_end

        test bl, bl
        jnz .loop_begin
    .loop_end:

    seta al
    setb bl
    sub al, bl
    movsx eax, al
    ret

string_n_compare_normalized:
    xor edx, edx
    xor eax, eax

    .loop_begin:
        cmp edx, r10d
        jnb .out_of_bounds

        mov al, [r8 + rdx]
        mov bl, [r9 + rdx]
        inc edx
        sub al, bl
        jnz .loop_end

        test bl, bl
        jnz .loop_begin
    .loop_end:

    seta al
    setb bl
    sub al, bl
    movsx eax, al
.out_of_bounds:
    ret

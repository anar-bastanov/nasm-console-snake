%include "anrc/callclib.inc"
%include "include/qrgen.inc"
%include "include/static_strings.inc"
%include "include/config.inc"

global program_entry

section .text

program_entry:
    call initialize_environment
    call configure_mode

    xor eax, eax
    ret

initialize_environment:
    push r8
    push r9

    mov r8d, [rel cc_LC_ALL]
    lea r9, [rel str_utf8_locale]
    callclib 2, setlocale

    pop r9
    pop r8
    ret

%include "argparse/parser.inc"
%include "anrc/callclib.inc"
%include "include/static_strings.inc"

global configure_mode

section .text

configure_mode:
    push r8
    push r9

    lea r8, [rel program_str_cli_arguments]
    call args_initialize

    pop r9
    pop r8
    ret

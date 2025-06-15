global str_utf8_locale
global program_str_cli_arguments
global program_str_usage

section .rodata

str_utf8_locale:
    db ".UTF8", 0

program_str_cli_arguments:
    db "a", 0
    db "b", 0
    db "c", 0

program_str_usage:
    db "This is how to use this command", 10, 0

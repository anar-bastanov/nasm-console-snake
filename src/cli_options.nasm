%include "anrc/all"
%include "argparse/all"
%include "main.inc"

global parse_user_options

section .text

parse_user_options:
    push r8
    push r9

    lea r8, [rel main_args_container]
    lea r9, [rel cli_option_list]
    mov r10d, cli_option_list_count - 1
    call args_initialize

    .loop:
        call args_parse_next
        test al, al
        jnz .loop

;     lea r8, [rel str_help_command]
;     callclib 1, printf

    pop r9
    pop r8
    ret

handler_argument:
    push r8
    push r9
    push r10
    mov r10d, r9d
    mov r9, [r8]
    lea r8, [rel str_printf_1]
    callclib 3, printf
    pop r10
    pop r9
    pop r8
    ret

handler_i:
handler_input:
    push r8
    push r9
    push r10
    mov r10d, r9d
    mov r9, [r8]
    lea r8, [rel str_printf_2]
    callclib 3, printf
    pop r10
    pop r9
    pop r8
    ret

handler_o:
handler_output:
    push r8
    push r9
    push r10
    mov r10d, r9d
    mov r9, [r8]
    lea r8, [rel str_printf_3]
    callclib 3, printf
    pop r10
    pop r9
    pop r8
    ret

handler_unknown_option:
    push r8
    push r9
    push r10
    mov r10d, r9d
    mov r9, [r8]
    lea r8, [rel str_printf_4]
    callclib 3, printf
    pop r10
    pop r9
    pop r8
    ret

section .data

OPT_LIST cli_option_list
    dopt handler_argument, ""
    dopt handler_i, "i"
    dopt handler_input, "-input"
    dopt handler_o, "o"
    dopt handler_output, "-output"
    dopt handler_unknown_option, "?"
ENDOPT

section .rodata

str_printf_1:
    db "argument: at %s, count %i", 10, 0

str_printf_2:
    db "input: at %s, count %i", 10, 0

str_printf_3:
    db "output: at %s, count %i", 10, 0

str_printf_4:
    db "unknown: at %s, count %i", 10, 0

str_help_command:
    db "Usage:", 10
    db "  qrgen <text> [options]", 10
    db 10
    db "Input/Output:", 10
    db "  -i, --input <file>        Read input text from file or stdin (-)", 10
    db "  -o, --output <file>       Write result to file or stdout (-)", 10
    db "  -f, --format <txt|pbm|bits|hex|bin|c>", 10
    db "                            Output format (default: txt)", 10
    db 10
    db "Encoding:", 10
    db "  -v, --version <1-40>      Force specific QR version", 10
    db "  -e, --eclevel <L|M|Q|H>   Error correction level (default: M)", 10
    db "  -m, --mode <byte|alnum|num>", 10
    db "                            Force encoding mode", 10
    db "  -k, --mask <0-7>          Force QR mask pattern", 10
    db "  -p, --pack <1|8|16>       Bits per module for raw output (default: 8)", 10
    db 10
    db "Appearance:", 10
    db "  -S, --scale <n>           Scale each module by n (default: 1)", 10
    db "  -M, --margin <n>          Whitespace border in modules (default: 4)", 10
    db "  -I, --invert              Swap light/dark module representation", 10
    db 10
    db "Rendering:", 10
    db "      --module-on <char>    Character for dark modules (default: ██)", 10
    db "      --module-off <char>   Character for light modules (default: space)", 10
    db 10
    db "Display:", 10
    db "  -n, --info                Print QR matrix info before output", 10
    db "  -q, --quiet               Suppress non-essential output", 10
    db 10
    db "Misc:", 10
    db "  -h, --help                Show this help message", 10
    db "  -H, --help-verbose        Show detailed option breakdown", 10
    db "      --lucky               ???", 10, 0

str_help_verbose_command:
    db "Usage:", 10
    db "  qrgen <text> [options]", 10
    db 10
    db "<text> is the main content to encode. If omitted, use --input to read from file or stdin.", 10
    db 10
    db "Input/Output:", 10
    db "  -i, --input <file>", 10
    db "      Read input text from file. Use '-' for stdin.", 10
    db 10
    db "  -o, --output <file>", 10
    db "      Write output to file. Use '-' for stdout.", 10
    db 10
    db "  -f, --format txt", 10
    db "      Terminal text output (default)", 10
    db "  -f, --format pbm", 10
    db "      Monochrome image (Portable Bitmap P1 format)", 10
    db "  -f, --format bits", 10
    db "      Raw binary stream of module bits (bit-packed, no newlines)", 10
    db "  -f, --format hex", 10
    db "      Hexadecimal string form (e.g., FF00A1C2...)", 10
    db "  -f, --format bin", 10
    db "      Binary string form (e.g., 01001101...)", 10
    db "  -f, --format c", 10
    db "      Escaped byte stream for embedding (e.g., \\xFF\\x00)", 10
    db 10
    db "Encoding:", 10
    db "  -v, --version <1-40>", 10
    db "      Use a specific QR version. Default: auto-selected based on input length.", 10
    db 10
    db "  -e, --eclevel L", 10
    db "      Low error correction (~7%% redundancy)", 10
    db "  -e, --eclevel M", 10
    db "      Medium error correction (~15%%) [default]", 10
    db "  -e, --eclevel Q", 10
    db "      Quartile error correction (~25%%)", 10
    db "  -e, --eclevel H", 10
    db "      High error correction (~30%%)", 10
    db 10
    db "  -m, --mode byte", 10
    db "      Byte mode (binary-safe UTF-8 or raw data)", 10
    db "  -m, --mode alnum", 10
    db "      Alphanumeric mode (A-Z, 0-9, and limited symbols)", 10
    db "  -m, --mode num", 10
    db "      Numeric mode (digits only)", 10
    db 10
    db "  -k, --mask 0-7", 10
    db "      Use a fixed mask pattern (0-7). Default: auto-optimize.", 10
    db 10
    db "  -p, --pack 1", 10
    db "      1 bit per module, fully packed into byte stream", 10
    db "  -p, --pack 8", 10
    db "      Each module stored in 1 byte (8 bits)", 10
    db "  -p, --pack 16", 10
    db "      Each module stored in 2 bytes (16 bits)", 10
    db 10
    db "Appearance:", 10
    db "  -S, --scale <n>", 10
    db "      Each module is expanded to an n by n block. (default: 1)", 10
    db 10
    db "  -M, --margin <n>", 10
    db "      Adds whitespace border of n modules around the QR. (default: 4)", 10
    db 10
    db "  -I, --invert", 10
    db "      Inverts module polarity: dark <-> light (applies to all formats)", 10
    db 10
    db "Rendering:", 10
    db "      --module-on <char>", 10
    db "          Character used to print dark modules (default: ██)", 10
    db 10
    db "      --module-off <char>", 10
    db "          Character used to print light modules (default: space)", 10
    db 10
    db "Display:", 10
    db "  -n, --info", 10
    db "      Print details: input length, version, size, mask used, error correction level, etc.", 10
    db 10
    db "  -q, --quiet", 10
    db "      Suppress all non-error output, including --info", 10
    db 10
    db "Miscellaneous:", 10
    db "  -h, --help", 10
    db "      Show summary of options", 10
    db 10
    db "  -H, --help-verbose", 10
    db "      Show this full breakdown of flags and values", 10
    db 10
    db "      --lucky", 10
    db "          ???", 10, 0

%ifndef __SNAKE_STRINGS_INC__
%define __SNAKE_STRINGS_INC__

section .rodata

test_str:
    db "╔═╗", 10
    db "║█║", 10
    db "╚═╝", 10, 0

utf8_locale_str:
    db ".UTF8", 0

%endif

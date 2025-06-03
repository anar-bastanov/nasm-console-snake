%ifndef __SNAKE_STRINGS_INC__
%define __SNAKE_STRINGS_INC__

section .rodata

test_str:
    db "aaaa"
    db ANSI_CURSOR_MOVE_DOWN()
    db "bb", 10
    db ANSI_CURSOR_MOVE_NEXT_LINE()
    db ANSI_SET_FG(ANSI_FG_RGB(120, 80, 170), "Hello there!"), 10
    db ANSI_SET_FG(ANSI_FG_GREEN, "My name is ")
    db ANSI_SET_FG_MD(ANSI_FG_RED, ANSI_MD_UNDERLINE, "NOT")
    db ANSI_SET_FG(ANSI_FG_GREEN, " Anar!"), 10
    db "╔═╗", 10
    db "║█║", 10
    db "╚═╝", 10
    db ANSI_CURSOR_DISABLE(), 0

utf8_locale_str:
    db ".UTF8", 0

%endif

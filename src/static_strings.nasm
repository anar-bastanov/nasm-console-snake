%include "styling/ansi.inc"

global test_str
global utf8_locale_str

section .rodata

test_str:
    db "aaaa"
    db ANSI_CURSOR_MOVE_DOWN()
    db "bb", 10
    db ANSI_CURSOR_MOVE_NEXT_LINE_BY(1 + 1)
    db ANSI_SET_FG(ANSI_RGB(120, 80, 170)), "Hello there! ", 10
    db ANSI_SET_FG(ANSI_GREEN), "My name is "
    db ANSI_SET_FG_MD(ANSI_RED, ANSI_UNDERLINE, ANSI_BOLD), "NOT"
    db ANSI_SET_CL_MD(ANSI_GREEN, ANSI_YELLOW, ANSI_FAINT), " Anar!", ANSI_RESET_FG_BG_MD(ANSI_FAINT), 10,
    db "Eh eh", 10
    db 10
    db "Normal", 10
    db ANSI_SET_MD(ANSI_ITALIC)
    db "Underline 1", 10
    db ANSI_SET_MD(ANSI_BOLD, ANSI_STRIKE)
    db "Underline 2", 10
    db ANSI_SET_FG_MD(ANSI_YELLOW, ANSI_STRIKE)
    db ANSI_RESET_MD(ANSI_ITALIC)
    db "Normal again", 10
    db 10
    db "Will it work?", 10
    db ANSI_SET_FG(ANSI_GREEN),
    db "╔══╗", 10
    db ANSI_SET_FG(ANSI_RED),
    db "║██║", 10
    db ANSI_SET_FG(ANSI_BLUE),
    db "╚══╝", 10
    db ANSI_RESET_FG(),
    db "It works!", 10
    db ANSI_CURSOR_MOVE_NEXT_LINE_BY("%i")
    db "%i", 10
    db ANSI_CURSOR_DISABLE(), 0

utf8_locale_str:
    db ".UTF8", 0

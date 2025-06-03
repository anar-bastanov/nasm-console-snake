%ifndef __ANSI_INC__
%define __ANSI_INC__

%include "styling/_macro_utils.internal.inc"

%xdefine ESC `\033`
%xdefine CSI CONCAT(ESC, "[")

%xdefine ANSI_ATTR_RESET         "0"

%xdefine ANSI_MD_BOLD            "1"
%xdefine ANSI_MD_FAINT           "2"
%xdefine ANSI_MD_ITALIC          "3"
%xdefine ANSI_MD_UNDERLINE       "4"
%xdefine ANSI_MD_SLOW_BLINK      "5"
%xdefine ANSI_MD_REVERSE_VIDEO   "7"
%xdefine ANSI_MD_CONCEAL         "8"
%xdefine ANSI_MD_STRIKE          "9"

%xdefine ANSI_FG_BLACK           "30"
%xdefine ANSI_FG_RED             "31"
%xdefine ANSI_FG_GREEN           "32"
%xdefine ANSI_FG_YELLOW          "33"
%xdefine ANSI_FG_BLUE            "34"
%xdefine ANSI_FG_MAGENTA         "35"
%xdefine ANSI_FG_CYAN            "36"
%xdefine ANSI_FG_WHITE           "37"
%define  ANSI_FG_INDEX(=n)       CONCAT("38;5;", n)
%define  ANSI_FG_RGB(=r, =g, =b) CONCAT("38;2;", r, ";", g, ";", b)
%xdefine ANSI_FG_DEFAULT         "39"

%xdefine ANSI_BG_BLACK           "40"
%xdefine ANSI_BG_RED             "41"
%xdefine ANSI_BG_GREEN           "42"
%xdefine ANSI_BG_YELLOW          "43"
%xdefine ANSI_BG_BLUE            "44"
%xdefine ANSI_BG_MAGENTA         "45"
%xdefine ANSI_BG_CYAN            "46"
%xdefine ANSI_BG_WHITE           "47"
%define  ANSI_BG_INDEX(=n)       CONCAT("48;5;", n)
%define  ANSI_BG_RGB(=r, =g, =b) CONCAT("48;2;", r, ";", g, ";", b)
%xdefine ANSI_BG_DEFAULT         "49"

%xdefine ANSI_TEXT_WRAP_ENABLE()      CONCAT(CSI, "=7h")
%xdefine ANSI_TEXT_WRAP_DISABLE()     CONCAT(CSI, "=7l")
     
%xdefine ANSI_CURSOR_ENABLE()         CONCAT(CSI, "?25h")
%xdefine ANSI_CURSOR_DISABLE()        CONCAT(CSI, "?25l")

%xdefine ANSI_REVERSE_VIDEO_ENABLE()  CONCAT(CSI, "?5h")
%xdefine ANSI_REVERSE_VIDEO_DISABLE() CONCAT(CSI, "?5l")

%xdefine ANSI_CURSOR_POSITION_RESET()     CONCAT(CSI,            "H")
%define  ANSI_CURSOR_POSITION_SET(=n, =m) CONCAT(CSI, n, ";", n, "H")
%xdefine ANSI_CURSOR_POSITION_SAVE()      CONCAT(CSI, "7")
%xdefine ANSI_CURSOR_POSITION_RESTORE()   CONCAT(CSI, "8")

%xdefine ANSI_CURSOR_MOVE_UP()         CONCAT(CSI,    "A")
%define  ANSI_CURSOR_MOVE_UP_BY(=n)    CONCAT(CSI, n, "A")
%xdefine ANSI_CURSOR_MOVE_DOWN()       CONCAT(CSI,    "B")
%define  ANSI_CURSOR_MOVE_DOWN_BY(=n)  CONCAT(CSI, n, "B")
%xdefine ANSI_CURSOR_MOVE_RIGHT()      CONCAT(CSI,    "C")
%define  ANSI_CURSOR_MOVE_RIGHT_BY(=n) CONCAT(CSI, n, "C")
%xdefine ANSI_CURSOR_MOVE_LEFT()       CONCAT(CSI,    "D")
%define  ANSI_CURSOR_MOVE_LEFT_BY(=n)  CONCAT(CSI, n, "D")

%xdefine ANSI_CURSOR_MOVE_NEXT_LINE()          CONCAT(CSI,    "E")
%define  ANSI_CURSOR_MOVE_NEXT_LINE_BY(=n)     CONCAT(CSI, n, "E")
%xdefine ANSI_CURSOR_MOVE_PREVIOUS_LINE()      CONCAT(CSI,    "F")
%define  ANSI_CURSOR_MOVE_PREVIOUS_LINE_BY(=n) CONCAT(CSI, n, "F")

%xdefine ANSI_CLEAR_FORWARD()       CONCAT(CSI,  "J")
%xdefine ANSI_CLEAR_BACKWARD()      CONCAT(CSI, "1J")
%xdefine ANSI_CLEAR_ALL()           CONCAT(CSI, "2J")

%xdefine ANSI_CLEAR_LINE_FORWARD()  CONCAT(CSI,  "K")
%xdefine ANSI_CLEAR_LINE_BACKWARD() CONCAT(CSI, "1K")
%xdefine ANSI_CLEAR_LINE()          CONCAT(CSI, "2K")

; Disabling markdowns could be done better
; Cannot disable ANSI_MD_BOLD
%define __ANSI_CREATE_ATTR(attr)               CONCAT(CSI, attr,                    "m")
%define __ANSI_CREATE_ATTRS(attr, others+)     CONCAT(CSI, JOIN(";", attr, others), "m")
%define __ANSI_ATTR_DISABLE_MARKDOWN(markdown) CONCAT("2", markdown)

; Fix the problem with NASM's "recursive" macro rule
%define ANSI_SET_MD(markdown, text+)                               CONCAT(__ANSI_CREATE_ATTR(markdown),                          JOIN(__ANSI_CREATE_ATTR(markdown), text),                          __ANSI_CREATE_ATTR(__ANSI_ATTR_DISABLE_MARKDOWN(markdown)))
%define ANSI_SET_BG(background, text+)                             CONCAT(__ANSI_CREATE_ATTR(background),                        JOIN(__ANSI_CREATE_ATTR(background), text),                        __ANSI_CREATE_ATTR(ANSI_BG_DEFAULT))
%define ANSI_SET_FG(foreground, text+)                             CONCAT(__ANSI_CREATE_ATTR(foreground),                        JOIN(__ANSI_CREATE_ATTR(foreground), text),                        __ANSI_CREATE_ATTR(ANSI_FG_DEFAULT))
%define ANSI_SET_FG_BG(foreground, background, text+)              CONCAT(__ANSI_CREATE_ATTRS(foreground, background),           JOIN(__ANSI_CREATE_ATTRS(foreground, background), text),           __ANSI_CREATE_ATTRS(ANSI_FG_DEFAULT, ANSI_BG_DEFAULT))
%define ANSI_SET_BG_MD(background, markdown, text+)                CONCAT(__ANSI_CREATE_ATTRS(background, markdown),             JOIN(__ANSI_CREATE_ATTRS(background, markdown), text),             __ANSI_CREATE_ATTRS(ANSI_BG_DEFAULT, __ANSI_ATTR_DISABLE_MARKDOWN(markdown)))
%define ANSI_SET_FG_MD(foreground, markdown, text+)                CONCAT(__ANSI_CREATE_ATTRS(foreground, markdown),             JOIN(__ANSI_CREATE_ATTRS(foreground, markdown), text),             __ANSI_CREATE_ATTRS(ANSI_FG_DEFAULT, __ANSI_ATTR_DISABLE_MARKDOWN(markdown)))
%define ANSI_SET_FG_BG_MD(foreground, background, markdown, text+) CONCAT(__ANSI_CREATE_ATTRS(foreground, background, markdown), JOIN(__ANSI_CREATE_ATTRS(foreground, background, markdown), text), __ANSI_CREATE_ATTRS(ANSI_FG_DEFAULT, ANSI_BG_DEFAULT, __ANSI_ATTR_DISABLE_MARKDOWN(markdown)))

; `%xdefine` here too?
%define ANSI_RESET_CL()         __ANSI_CREATE_ATTRS(ANSI_FG_DEFAULT, ANSI_BG_DEFAULT)
%define ANSI_RESET_MD(markdown) __ANSI_CREATE_ATTR(__ANSI_ATTR_DISABLE_MARKDOWN(markdown))
%define ANSI_RESET_ALL()        __ANSI_CREATE_ATTR(ANSI_ATTR_RESET)

%endif
 
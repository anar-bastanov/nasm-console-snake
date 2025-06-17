%ifndef __ANSI_INTERNAL_INC__
%define __ANSI_INTERNAL_INC__

%include "styling/_macro_utils.internal.inc"

%xdefine ESC `\033`
%xdefine CSI CONCAT(ESC, "[")

%xdefine ANSI_ATTR_RESET      "0"

%xdefine ANSI_BLACK           "0"
%xdefine ANSI_RED             "1"
%xdefine ANSI_GREEN           "2"
%xdefine ANSI_YELLOW          "3"
%xdefine ANSI_BLUE            "4"
%xdefine ANSI_MAGENTA         "5"
%xdefine ANSI_CYAN            "6"
%xdefine ANSI_WHITE           "7"
%define  ANSI_INDEX(n)        CONCAT("8;5;", n)
%define  ANSI_RGB(r, g, b)    CONCAT("8;2;", r, ";", g, ";", b)
%xdefine ANSI_DEFAULT         "9"

%xdefine ANSI_BOLD            "1"
%xdefine ANSI_FAINT           "2"
%xdefine ANSI_ITALIC          "3"
%xdefine ANSI_UNDERLINE       "4"
%xdefine ANSI_SLOW_BLINK      "5"
%xdefine ANSI_REVERSE_VIDEO   "7"
%xdefine ANSI_CONCEAL         "8"
%xdefine ANSI_STRIKE          "9"

%define  __ANSI_CREATE_ATTR(attr)           CONCAT(CSI, attr,                      "m")
%define  __ANSI_CREATE_ATTRS(attr1, attrn+) CONCAT(CSI, JOIN(";", attr1 %, attrn), "m")

%define  __ANSI_FG(foreground)        CONCAT("3", foreground)
%define  __ANSI_BG(background)        CONCAT("4", background)

%define  __ANSI_MD_REVERT_ONE(markdown)   CONCAT("2", %cond(markdown = ANSI_BOLD, ANSI_FAINT, markdown))
%define  __ANSI_MD_REVERT(md1, mdn+)      SELECT(__ANSI_MD_REVERT_ONE, md1 %, mdn)
%xdefine __ANSI_MD_REVERT_ALL()           __ANSI_MD_REVERT(ANSI_FAINT, ANSI_ITALIC, ANSI_UNDERLINE, ANSI_SLOW_BLINK, ANSI_REVERSE_VIDEO, ANSI_CONCEAL, ANSI_STRIKE)

%define  ANSI_SET_FG(foreground)                              __ANSI_CREATE_ATTR(__ANSI_FG(foreground))
%define  ANSI_SET_BG(background)                              __ANSI_CREATE_ATTR(__ANSI_BG(background))
%define  ANSI_SET_MD(md1, mdn+)                               __ANSI_CREATE_ATTRS(md1 %, mdn)
%define  ANSI_SET_FG_BG(foreground, background)               __ANSI_CREATE_ATTRS(__ANSI_FG(foreground), __ANSI_BG(background))
%define  ANSI_SET_FG_MD(foreground, md1, mdn+)                __ANSI_CREATE_ATTRS(__ANSI_FG(foreground), md1 %, mdn)
%define  ANSI_SET_BG_MD(background, md1, mdn+)                __ANSI_CREATE_ATTRS(__ANSI_BG(background), md1 %, mdn)
%define  ANSI_SET_FG_BG_MD(foreground, background, md1, mdn+) __ANSI_CREATE_ATTRS(__ANSI_FG(foreground), __ANSI_BG(background), md1 %, mdn)

%define  ANSI_SET_CL(foreground, background)                  ANSI_SET_FG_BG(foreground, background)
%define  ANSI_SET_CL_MD(foreground, background, md1, mdn+)    ANSI_SET_FG_BG_MD(foreground, background, md1 %, mdn)
%define  ANSI_SET_ALL(foreground, background, md1, mdn+)      ANSI_SET_FG_BG_MD(foreground, background, md1 %, mdn)

%xdefine ANSI_RESET_FG()                __ANSI_CREATE_ATTR(__ANSI_FG(ANSI_DEFAULT))
%xdefine ANSI_RESET_BG()                __ANSI_CREATE_ATTR(__ANSI_BG(ANSI_DEFAULT))
%define  ANSI_RESET_MD(md1, mdn+)       __ANSI_CREATE_ATTRS(__ANSI_MD_REVERT(md1 %, mdn))
%xdefine ANSI_RESET_MD()                __ANSI_CREATE_ATTRS(__ANSI_MD_REVERT_ALL())
%xdefine ANSI_RESET_FG_BG()             __ANSI_CREATE_ATTRS(__ANSI_FG(ANSI_DEFAULT), __ANSI_BG(ANSI_DEFAULT))
%define  ANSI_RESET_FG_MD(md1, mdn+)    __ANSI_CREATE_ATTRS(__ANSI_FG(ANSI_DEFAULT), __ANSI_MD_REVERT(md1 %, mdn))
%xdefine ANSI_RESET_FG_MD()             __ANSI_CREATE_ATTRS(__ANSI_FG(ANSI_DEFAULT), __ANSI_MD_REVERT_ALL())
%define  ANSI_RESET_BG_MD(md1, mdn+)    __ANSI_CREATE_ATTRS(__ANSI_BG(ANSI_DEFAULT), __ANSI_MD_REVERT(md1 %, mdn))
%xdefine ANSI_RESET_BG_MD()             __ANSI_CREATE_ATTRS(__ANSI_BG(ANSI_DEFAULT), __ANSI_MD_REVERT_ALL())
%define  ANSI_RESET_FG_BG_MD(md1, mdn+) __ANSI_CREATE_ATTRS(__ANSI_FG(ANSI_DEFAULT), __ANSI_BG(ANSI_DEFAULT), __ANSI_MD_REVERT(md1 %, mdn))
%xdefine ANSI_RESET_FG_BG_MD()          __ANSI_CREATE_ATTR(ANSI_ATTR_RESET)

%xdefine ANSI_RESET_CL()                ANSI_RESET_FG_BG()
%define  ANSI_RESET_CL_MD(md1, mdn+)    ANSI_RESET_FG_BG_MD(md1 %, mdn)
%xdefine ANSI_RESET_CL_MD()             ANSI_RESET_FG_BG_MD()
%xdefine ANSI_RESET_ALL()               ANSI_RESET_FG_BG_MD()

%xdefine ANSI_TEXT_WRAP_ENABLE()      CONCAT(CSI, "=7h")
%xdefine ANSI_TEXT_WRAP_DISABLE()     CONCAT(CSI, "=7l")
     
%xdefine ANSI_REVERSE_VIDEO_ENABLE()  CONCAT(CSI, "?5h")
%xdefine ANSI_REVERSE_VIDEO_DISABLE() CONCAT(CSI, "?5l")

%xdefine ANSI_CURSOR_ENABLE()         CONCAT(CSI, "?25h")
%xdefine ANSI_CURSOR_DISABLE()        CONCAT(CSI, "?25l")

%xdefine ANSI_CURSOR_POSITION_RESET()     CONCAT(CSI,            "H")
%define  ANSI_CURSOR_POSITION_SET(n, m)   CONCAT(CSI, n, ";", n, "H")
%xdefine ANSI_CURSOR_POSITION_SAVE()      CONCAT(CSI, "7")
%xdefine ANSI_CURSOR_POSITION_RESTORE()   CONCAT(CSI, "8")

%xdefine ANSI_CURSOR_MOVE_UP()         CONCAT(CSI,    "A")
%define  ANSI_CURSOR_MOVE_UP_BY(n)     CONCAT(CSI, n, "A")
%xdefine ANSI_CURSOR_MOVE_DOWN()       CONCAT(CSI,    "B")
%define  ANSI_CURSOR_MOVE_DOWN_BY(n)   CONCAT(CSI, n, "B")
%xdefine ANSI_CURSOR_MOVE_RIGHT()      CONCAT(CSI,    "C")
%define  ANSI_CURSOR_MOVE_RIGHT_BY(n)  CONCAT(CSI, n, "C")
%xdefine ANSI_CURSOR_MOVE_LEFT()       CONCAT(CSI,    "D")
%define  ANSI_CURSOR_MOVE_LEFT_BY(n)   CONCAT(CSI, n, "D")

%xdefine ANSI_CURSOR_MOVE_NEXT_LINE()          CONCAT(CSI,    "E")
%define  ANSI_CURSOR_MOVE_NEXT_LINE_BY(n)      CONCAT(CSI, n, "E")
%xdefine ANSI_CURSOR_MOVE_PREVIOUS_LINE()      CONCAT(CSI,    "F")
%define  ANSI_CURSOR_MOVE_PREVIOUS_LINE_BY(n)  CONCAT(CSI, n, "F")

%xdefine ANSI_CLEAR_FORWARD()       CONCAT(CSI,  "J")
%xdefine ANSI_CLEAR_BACKWARD()      CONCAT(CSI, "1J")
%xdefine ANSI_CLEAR_ALL()           CONCAT(CSI, "2J")

%xdefine ANSI_CLEAR_LINE_FORWARD()  CONCAT(CSI,  "K")
%xdefine ANSI_CLEAR_LINE_BACKWARD() CONCAT(CSI, "1K")
%xdefine ANSI_CLEAR_LINE()          CONCAT(CSI, "2K")

%endif
 
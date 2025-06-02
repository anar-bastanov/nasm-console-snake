%ifndef __CLIB_CONSTS_INTERNAL_INC__
%define __CLIB_CONSTS_INTERNAL_INC__

%macro __import_c_const 0-*
    %rep %0
        extern __c_%1
        %define c_%1 rel __c_%1
    %endrep
%endmacro

__import_c_const \
    LC_ALL, \
    LC_COLLATE, \
    LC_CTYPE, \
    LC_MONETARY, \
    LC_NUMERIC, \
    LC_TIME

%endif

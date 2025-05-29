%ifndef __CALLCLIB_ARGC_INC__
%define __CALLCLIB_ARGC_INC__

%define CALLCLIB_MAX_ARG_COUNT 8

%define VALID
%ifnnum CALLCLIB_MAX_ARG_COUNT
    %undef VALID
%endif
%ifn CALLCLIB_MAX_ARG_COUNT >= 0
    %undef VALID
%endif
%ifndef VALID
    %fatal Invalid value for count
%endif

%endif

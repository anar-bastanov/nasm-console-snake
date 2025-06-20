%ifndef __CALLCLIB_ARGC_INC__
%define __CALLCLIB_ARGC_INC__

%define CALLCLIB_MAX_ARG_COUNT 12

%if %isnnum(CALLCLIB_MAX_ARG_COUNT) || CALLCLIB_MAX_ARG_COUNT < 0
    %fatal Invalid value for count.
%endif

%endif

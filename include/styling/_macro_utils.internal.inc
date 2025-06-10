%ifndef __MACRO_UTILS_INTERNAL_INC__
%define __MACRO_UTILS_INTERNAL_INC__

%define SELECT(selector)        ""
%define SELECT(selector, args+) %map(selector %, args)

%define CONCAT()    ""
%define CONCAT(sn+) %strcat(sn)

%define __JOIN(delimiter, str)   delimiter, str
%define JOIN(delimiter)          ""
%define JOIN(delimiter, s1, sn+) %strcat(s1, %map(__JOIN:(delimiter) %, sn))

%endif

%ifndef __MACRO_UTILS_INTERNAL_INC__
%define __MACRO_UTILS_INTERNAL_INC__

; %define STR(value) %str(value)

; %define ESCAPE_COMMA(a, b+) %cond(%isempty(a) && %isempty(b), "", {a %tok(%cond(%isnempty(a) && %isnempty(b), ",", )) b})

; %define AGGREGATE(init, accumulator)                        init
; %define __AGGREGATE(aggregate, accumulator, current)        accumulator(aggregate, current)
; %define __AGGREGATE(aggregate, accumulator, current, args+) %map(__AGGREGATE:(aggregate, accumulator, current), args)
; %define AGGREGATE(init, accumulator, args+)                 __AGGREGATE(init, accumulator, args)

%define SELECT(selector)        ""
%define SELECT(selector, args+) %map(selector %, args)

%define JOIN(delimiter)          ""
%define __JOIN(delimiter, str)   delimiter, str
%define JOIN(delimiter, s1, sn+) %strcat(s1, %map(__JOIN:(delimiter) %, sn))

%define CONCAT()        ""
%define __CONCAT(str)   str
%define CONCAT(s1, sn+) %strcat(s1, %map(__CONCAT %, sn))

%endif

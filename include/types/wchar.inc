%ifndef __WCHAR_INC__
%define __WCHAR_INC__

%imacro dwcs 1-*
    %rep %0
        %ifempty %1
            %error Argument expected after comma.
        %elifstr %1
            %assign i 1
            %rep %strlen(%1)
                dw %substr(%1, i, 1)
                %assign i i + 1
            %endrep
        %elifnum %1
            dw %1
        %else
            %error Expected a number or a string literal.
        %endif

        %rotate 1
    %endrep
%endmacro

%endif

#include <utility>

extern "C"
{
    #include <cstdio>
    #include <cmath>
    #include <ctime>
    #include <cwchar>
    #include <clocale>
}

extern "C"
{
    int __c_LC_ALL      = LC_ALL;
    int __c_LC_COLLATE  = LC_COLLATE;
    int __c_LC_CTYPE    = LC_CTYPE;
    int __c_LC_MONETARY = LC_MONETARY;
    int __c_LC_NUMERIC  = LC_NUMERIC;
    int __c_LC_TIME     = LC_TIME;
}

constexpr const std::initializer_list<void *> &_ =
{
    nullptr
    #define extern ,(void*)
    #include "_clib.internal.inc"
};

#include <utility>

extern "C"
{
    #include <cstdio>
    #include <cmath>
    #include <ctime>
    #include <cwchar>
    #include <clocale>
}

#define extern ,(void*)

constexpr const std::initializer_list<void *> &_ =
{
    nullptr
    #include "_clib.internal.inc"
};

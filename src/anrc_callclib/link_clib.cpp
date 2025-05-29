#include <utility>

extern "C"
{
    #include <cstdio>
    #include <cwchar>
}

#define extern ,(void*)

constexpr const std::initializer_list<void *> &_ =
{
    nullptr
    #include "anrc_callclib/clib.inc"
};

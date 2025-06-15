#include <utility>

extern "C"
{
    #include <cmath>
    #include <cfenv>
    #include <cstdio>
    #include <ctime>
    #include <clocale>
}

extern "C"
{
    #define __c_const(const_name) auto cc_##const_name = const_name;
    #include "_clib_consts.internal.txt"
}

// // This was used to ensure standard library functions could be referenced
// // from NASM code, but it is no longer needed
// constexpr const std::initializer_list<void *> &_ =
// {
//     nullptr
//     #define __c_func ,(void*)
//     #include "_clib_funcs.internal.txt"
// };

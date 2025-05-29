cmake_minimum_required(VERSION 3.20)
project(nasm_console_snake LANGUAGES C CXX ASM_NASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Detect all nested include directories
file(GLOB_RECURSE ALL_INCLUDE_DIRS LIST_DIRECTORIES true include/*)

set(FINAL_INCLUDE_DIRS include)
foreach(path ${ALL_INCLUDE_DIRS})
    if(IS_DIRECTORY ${path})
        list(APPEND FINAL_INCLUDE_DIRS ${path})
    endif()
endforeach()

# Apply to both C/C++ and NASM
include_directories(${FINAL_INCLUDE_DIRS})

# Find all source files
file(GLOB_RECURSE C_SOURCES     src/*.c)
file(GLOB_RECURSE CPP_SOURCES   src/*.cpp)
file(GLOB_RECURSE NASM_SOURCES  src/*.nasm)
file(GLOB_RECURSE INC_FILES     include/*.inc)

# Create the executable target
add_executable(snake ${C_SOURCES} ${CPP_SOURCES} ${NASM_SOURCES})

# OS-specific options
if(WIN32)
    set(NASM_FORMAT win64)
    target_compile_definitions(snake PRIVATE WINDOWS)
else()
    set(NASM_FORMAT elf64)
    target_compile_definitions(snake PRIVATE LINUX)
endif()

# Tell CMake how to compile NASM files
foreach(source_file ${NASM_SOURCES})
    set_source_files_properties(${source_file} PROPERTIES
        LANGUAGE ASM_NASM
        NASM_OBJ_FORMAT ${NASM_FORMAT}
    )
endforeach()

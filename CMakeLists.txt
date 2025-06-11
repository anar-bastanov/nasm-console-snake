cmake_minimum_required(VERSION 3.20)
project(nasm_qr_generator LANGUAGES C CXX ASM_NASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Collect include paths (for NASM)
set(NASM_INCLUDE_DIRS "")
foreach(dir IN ITEMS
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/lib
)
    if(EXISTS "${dir}")
        file(GLOB_RECURSE subdirs LIST_DIRECTORIES true "${dir}/*")
        foreach(subdir ${subdirs})
            if(IS_DIRECTORY ${subdir})
                list(APPEND NASM_INCLUDE_DIRS ${subdir})
            endif()
        endforeach()
        list(APPEND NASM_INCLUDE_DIRS ${dir})
    endif()
endforeach()

# Include directories for C/C++
include_directories(${NASM_INCLUDE_DIRS})

# Collect source files
file(GLOB_RECURSE C_SOURCES   src/*.c   lib/*.c)
file(GLOB_RECURSE CPP_SOURCES src/*.cpp lib/*.cpp)
file(GLOB_RECURSE ASM_SOURCES src/*.nasm lib/*.nasm)

# Create executable
add_executable(qrgen ${C_SOURCES} ${CPP_SOURCES} ${ASM_SOURCES})

# Detect platform
if(WIN32)
    set(NASM_FORMAT win64)
    target_compile_definitions(qrgen PRIVATE WINDOWS)
else()
    set(NASM_FORMAT elf64)
    target_compile_definitions(qrgen PRIVATE LINUX)
endif()

# Build NASM flags (-I for include directories)
set(NASM_FLAGS "")
foreach(path ${NASM_INCLUDE_DIRS})
    list(APPEND NASM_FLAGS -I${path})
endforeach()

# Use target_compile_options to avoid COMPILE_FLAGS issues on Linux
foreach(path ${NASM_INCLUDE_DIRS})
    list(APPEND NASM_FLAGS -I${path})
endforeach()

# Set NASM format
if(WIN32)
    set(NASM_FORMAT win64)
    target_compile_definitions(qrgen PRIVATE WINDOWS)
else()
    set(NASM_FORMAT elf64)
    target_compile_definitions(qrgen PRIVATE LINUX)
endif()

# Apply NASM settings
foreach(src ${ASM_SOURCES})
    set_source_files_properties(${src} PROPERTIES
        LANGUAGE ASM_NASM
        NASM_OBJ_FORMAT ${NASM_FORMAT}
    )
endforeach()

# Apply include flags to the target (handles Linux properly)
target_compile_options(qrgen PRIVATE ${NASM_FLAGS})

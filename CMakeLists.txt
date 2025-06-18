cmake_minimum_required(VERSION 3.20)
project(nasm_qr_generator LANGUAGES C CXX ASM_NASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(LIB_DIR ${CMAKE_SOURCE_DIR}/lib)
set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(VIRTUAL_INC_DIR ${CMAKE_BINARY_DIR}/nasm_includes)
file(MAKE_DIRECTORY "${VIRTUAL_INC_DIR}")

set(DEPENDENCY_FILENAME "DEPENDENCIES.list")
set(PROJECT_DEP_FILE "${SRC_DIR}/${DEPENDENCY_FILENAME}")

# ---------------------- Dependency Parser ----------------------
function(parse_dependency_file depfile out_deplist)
    if(NOT EXISTS "${depfile}")
        set(${out_deplist} "" PARENT_SCOPE)
        return()
    endif()

    set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${depfile}")
    set(parsed "")
    
    file(READ "${depfile}" contents)
    string(REPLACE ";" "#" contents "${contents}")
    string(REPLACE "\n" ";" lines "${contents}")

    foreach(line IN LISTS lines)
        string(REGEX REPLACE "( |\\t|^)(#|//|--).*" "" line "${line}")
        string(STRIP "${line}" line)
    
        if(NOT line STREQUAL "" AND NOT line MATCHES "^\\[.*\\]$")
            list(APPEND parsed "${line}")
        endif()
    endforeach()

    set(${out_deplist} ${parsed} PARENT_SCOPE)
endfunction()

# ---------------------- Transitive Dependency Resolver ----------------------
function(resolve_dependencies result out_configure_deps)
    set(visited "")
    set(to_visit ${ARGN})
    set(dep_files "")

    while(to_visit)
        list(POP_FRONT to_visit current)

        if(NOT "${current}" MATCHES "[0-9A-Za-z_-]+")
            message(FATAL_ERROR "Invalid dependency name: ${current}")
        endif()

        if(NOT IS_DIRECTORY "${LIB_DIR}/${current}")
            message(FATAL_ERROR "Dependency is missing: ${current}")
        endif()

        if(NOT current IN_LIST visited)
            list(APPEND visited ${current})
            set(depfile "${LIB_DIR}/${current}/${DEPENDENCY_FILENAME}")

            parse_dependency_file("${depfile}" inner_list)
            list(APPEND dep_files "${depfile}")
            list(APPEND to_visit ${inner_list})
        endif()
    endwhile()

    set(${result} ${visited} PARENT_SCOPE)
    set(${out_configure_deps} ${dep_files} PARENT_SCOPE)
endfunction()

# ---------------------- Parse Project Dependency File ----------------------
set(ROOT_DEPS "")
if(EXISTS "${PROJECT_DEP_FILE}")
    parse_dependency_file("${PROJECT_DEP_FILE}" ROOT_DEPS)
endif()

# ---------------------- Resolve Transitive Dependencies ----------------------
if(ROOT_DEPS)
    resolve_dependencies(FINAL_DEP_LIST CONFIGURE_DEP_FILES ${ROOT_DEPS})
else()
    set(FINAL_DEP_LIST "")
    set(CONFIGURE_DEP_FILES "")
endif()

# ---------------------- Sync Interface Files ----------------------
file(GLOB OLD_DEP_DIRS RELATIVE ${VIRTUAL_INC_DIR} ${VIRTUAL_INC_DIR}/*)
set(NEW_INCLUDES "")

foreach(dep ${FINAL_DEP_LIST})
    message("Dependency added: ${dep}")
    file(GLOB_RECURSE FILES "${LIB_DIR}/${dep}/*")

    foreach(file ${FILES})
        get_filename_component(ext "${file}" EXT)
        get_filename_component(name "${file}" NAME)
    
        if((ext MATCHES "\\.(inc|txt|h|hpp|h\\+\\+)$") OR
           (ext STREQUAL "" AND name STREQUAL "all"))
            file(RELATIVE_PATH rel_path "${LIB_DIR}" "${file}")
            set(dest "${VIRTUAL_INC_DIR}/${rel_path}")
            get_filename_component(dest_dir "${dest}" DIRECTORY)
            file(MAKE_DIRECTORY "${dest_dir}")
            configure_file("${file}" "${dest}" COPYONLY)
            list(APPEND NEW_INCLUDES "${rel_path}")
        endif()
    endforeach()
endforeach()

# ---------------------- Remove Unused Dependencies ----------------------
file(GLOB CURRENT_DIRS RELATIVE ${VIRTUAL_INC_DIR} ${VIRTUAL_INC_DIR}/*)
foreach(dir ${CURRENT_DIRS})
    if(NOT dir IN_LIST FINAL_DEP_LIST)
        file(REMOVE_RECURSE "${VIRTUAL_INC_DIR}/${dir}")
    endif()
endforeach()

# ---------------------- Add Include Paths ----------------------
set(NASM_INCLUDE_DIRS ${SRC_DIR} ${SRC_DIR}/include ${VIRTUAL_INC_DIR})
include_directories(${SRC_DIR})

# ---------------------- Collect Source Files ----------------------
file(GLOB_RECURSE C_SOURCES   ${SRC_DIR}/*.c)
file(GLOB_RECURSE CPP_SOURCES ${SRC_DIR}/*.cpp)
file(GLOB_RECURSE ASM_SOURCES ${SRC_DIR}/*.nasm)

foreach(dep ${FINAL_DEP_LIST})
    file(GLOB_RECURSE LIB_C    "${LIB_DIR}/${dep}/*.c")
    file(GLOB_RECURSE LIB_CPP  "${LIB_DIR}/${dep}/*.cpp")
    file(GLOB_RECURSE LIB_ASM  "${LIB_DIR}/${dep}/*.nasm")

    list(APPEND C_SOURCES ${LIB_C})
    list(APPEND CPP_SOURCES ${LIB_CPP})
    list(APPEND ASM_SOURCES ${LIB_ASM})
endforeach()

# ---------------------- Add Executable ----------------------
add_executable(qrgen ${C_SOURCES} ${CPP_SOURCES} ${ASM_SOURCES})

if(WIN32)
    set(NASM_FORMAT win64)
    target_compile_definitions(qrgen PRIVATE WINDOWS)
else()
    set(NASM_FORMAT elf64)
    target_compile_definitions(qrgen PRIVATE LINUX)

    include(CheckPIESupported)
    check_pie_supported()
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
    target_compile_definitions(qrgen PRIVATE CLIB_PIC_CALL)

    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z noexecstack")
endif()

# ---------------------- Optimizations ----------------------
if(MSVC)
    target_compile_options(qrgen PRIVATE $<$<COMPILE_LANGUAGE:C,CXX>:/Gy>)
    target_link_options(qrgen PRIVATE /OPT:REF /OPT:ICF)
elseif(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(qrgen PRIVATE $<$<COMPILE_LANGUAGE:C,CXX>:-ffunction-sections -fdata-sections -g0>)
    target_link_options(qrgen PRIVATE -Wl,--gc-sections -Wl,-s)
endif()

# ---------------------- NASM Assembler Flags ----------------------
foreach(src ${ASM_SOURCES})
    set_source_files_properties(${src} PROPERTIES LANGUAGE ASM_NASM NASM_OBJ_FORMAT ${NASM_FORMAT})
endforeach()

set(NASM_FLAGS "")
foreach(path ${NASM_INCLUDE_DIRS})
    list(APPEND NASM_FLAGS -I${path})
endforeach()

target_compile_options(qrgen PRIVATE ${NASM_FLAGS})

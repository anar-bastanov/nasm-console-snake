@echo off
if not exist build (
    mkdir build
)

:: Step 1: Configure with CMake
cmake -S . -B build

:: Step 2: Build the project
cmake --build build

:: Step 3: Run the built executable in a new CMD window
start cmd /c build\bin\snake.exe

# Build Instructions

This project uses NASM and CMake to build a command-line Snake game. It is cross-platform and works on both Linux and Windows systems.

## Prerequisites

### Linux

Install the following tools using your distribution’s package manager:

```bash
sudo apt install nasm gcc cmake ninja-build
```

### Windows

Ensure the following are installed and added to your `PATH`:

* [NASM for Windows](https://www.nasm.us/)
* GCC (via [MinGW-w64](https://www.mingw-w64.org/), MSYS2, or WSL)
* [CMake](https://cmake.org/download/)
* [Ninja](https://ninja-build.org/) (optional, but recommended)

> If you're using WSL, install the Linux prerequisites listed above inside your WSL environment.

## File Structure

* `src/`: Contains all `.nasm`, `.c`, and `.cpp` source files, including subfolders
* `include/`: Contains `.inc` headers for NASM and `.h/.hpp` headers for C/C++
* `build/`: Intermediate build files (generated automatically)
* `bin/`: Output folder for the compiled executable

## Building

From the root of the repository, run:

```bash
cmake -S . -B build -G Ninja
cmake --build build
```

This will:

* Recursively compile all NASM, C, and C++ files in `src/`
* Include all headers from `include/`
* Place the output binary in the `bin/` directory

## Running

You can run the executable manually or use the helper scripts provided:

### Windows

```bash
run.bat
```

This script opens a new terminal window and runs the game.

### Cross-Platform (Windows, Linux, macOS)

```bash
python run.py
```

This script works on any OS with Python 3 installed. It builds the project if necessary, then runs the executable.

## Cleaning

To remove all build artifacts:

```bash
cmake --build build --target clean
```

Or, manually delete the `build/` and `bin/` directories.

## Output

The final executable will be:

* `bin/snake` on Linux/macOS
* `bin/snake.exe` on Windows

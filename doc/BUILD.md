# Build Instructions

This project uses NASM and CMake to build a terminal-based QR code generator. It is cross-platform and works on both Linux and Windows systems.

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

* `src/`: All source files (.nasm, .c, .cpp) and headers
* `lib/`: Shared or reusable code
* `doc/`: Documentation, specs, and build instructions
* `res/`: Resources such as static images
* `tools/`: Scripts for automation
* `build/`: Intermediate build files (generated automatically)

## Building

From the root of the repository, run:

```bash
cmake -S . -B build -G Ninja  # or remove -G Ninja if not using it
cd build/
cmake --build .
```

This will:

* Recursively compile all NASM, C, and C++ files in `src/` and `lib/`
* Link any reusable modules from `src/include/` and `lib/`
* Place the executable in the `build/bin/` directory

## Running

You can run the executable manually or use the helper scripts provided:

### Windows

```bash
cd tools/
run.bat
```

### Cross-Platform (Windows, Linux, macOS)

```bash
cd tools/
python run.py
```

This script works on any OS with Python 3 installed. It builds the project if necessary, then runs the executable.

## Cleaning

To remove all build artifacts:

```bash
cmake --build build --target clean
```

Or, manually delete the `build/` directory.

## Output

The final executable will be:

* `build/bin/snake` on Linux
* `build/bin/snake.exe` on Windows

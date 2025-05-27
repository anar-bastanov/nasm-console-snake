# Build Instructions

This project uses NASM and `make` to build a command-line Snake game. It is cross-platform and works on both Linux and Windows systems.

## Prerequisites

### Linux

* `nasm` – assembler
* `gcc` – used for linking and C standard library calls
* `make` – build automation tool

Install via package manager:

```bash
sudo apt install nasm make gcc
```

### Windows

* [NASM for Windows](https://www.nasm.us/)
* `gcc` (via [MinGW-w64](https://www.mingw-w64.org/), MSYS2, or WSL)
* `make` (provided by MSYS2 or WSL)

> If you're using WSL (Windows Subsystem for Linux), install the Linux prerequisites using your distribution's package manager.

## Building

To build the project, run:

```bash
make
```

This will:

* Assemble `.nasm` and `.c` files from `src/`
* Link object files located in the `build/` directory using `gcc` to ensure compatibility with standard C functions
* Output the executable into the `bin/` directory

## Cleaning

To remove build artifacts:

```bash
make clean
```

This deletes files from `build/` and `bin/`.

## Output

The final executable will be:

* `bin/snake` on Linux/macOS
* `bin/snake.exe` on Windows

The exact filename may vary depending on platform-specific logic in the [`Makefile`](/Makefile).

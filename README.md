# QR Code Generator (Assembly, NASM)

This repository contains a terminal-based QR code generator implemented in x86-64 assembly using NASM. It is fully cross-platform and runs in the command-line interface (CLI) without requiring external libraries.

The project uses the `__anrc64` calling convention, documented in [`CONVENTION.md`](doc/CONVENTION.md).

A visual overview and additional documentation are available on the [GitHub Wiki](https://github.com/anar-bastanov/qr-generator/wiki).

## Features

### QR Code Capabilities
* Generates standard QR codes with full error correction support (Levels L, M, Q, H)
* Supports alphanumeric and byte encoding modes
* Visual rendering of QR codes directly in the terminal using ANSI graphics
* Configurable output size and scale (grid units)
* Optimized for speed and small binary size

### Technical Highlights
* Fully written in x86-64 NASM assembly
* Cross-platform: works on both Linux and Windows
* No dependencies or runtime libraries required
* Modular and extensible structure (e.g., encoding logic, render logic, utilities)
* Dual build support via Makefile and CMake

## Building

Build instructions for supported platforms are available in [`BUILD.md`](doc/BUILD.md).

## License

Copyright © 2025 Anar Bastanov  
Distributed under the [MIT License](http://www.opensource.org/licenses/mit-license.php).

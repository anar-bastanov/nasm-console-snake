# Snake Game (Assembly, NASM)

This repository contains a terminal-based Snake game implemented in x86-64 assembly using NASM. The project is fully cross-platform and runs in the command-line interface (CLI) without requiring any external libraries.

The internal logic is built on top of a custom calling convention called `__anrc64`, designed for NASM-based x86-64 projects. The full specification is available in [`docs/CONVENTION.md`](docs/CONVENTION.md).

A visual demonstration of the game and additional documentation are available on the [GitHub Wiki](https://github.com/anar-bastanov/nasm-console-snake/wiki).

## Features

* Written entirely in x86-64 NASM assembly
* Cross-platform, Linux and Windows support
* Terminal-based gameplay with real-time input
* Minimal dependencies, runs directly in the CLI
* Simple Makefile-based build system
* Modular source structure for easier extension

## Building

Instructions for assembling and running the project on supported platforms are provided in the [`BUILD.md`](docs/BUILD.md) file.

## License
Copyright &copy; 2025 Anar Bastanov  
Distributed under the [MIT License](http://www.opensource.org/licenses/mit-license.php).

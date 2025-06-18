# qrgen - Command-Line QR Code Generator

`qrgen` is a fast, dependency-free, cross-platform command-line utility for generating QR codes. It encodes arbitrary text into customizable QR codes with fine-grained control over encoding logic and output formats.

## Features

* Input from direct text, file, or stdin
* Output in plain text, PBM image, bitstream, hex, binary, or escaped byte stream
* Full control over QR version, error correction level, mode, and mask
* Terminal rendering using UTF-8 blocks (e.g., `██`)
* Adjustable scaling, margin, polarity, and module rendering
* Lightweight and portable — no external dependencies
* Cross-platform support: builds on Linux and Windows

## Installation

See [`doc/build.md`](doc/build.md) for platform-specific build instructions using CMake.

## Usage

Refer to [`doc/usage.md`](doc/usage.md) for the full CLI help strings (`--help`, `--help-verbose`) and detailed usage patterns.

## Examples

See [`doc/examples.md`](doc/example.md) for input/output demonstrations and QR code rendering examples.

## Documentation

### For Users

* [`build.md`](doc/build.md) — Build and install instructions
* [`usage.md`](doc/usage.md) — CLI flags and usage breakdown
* [`examples.md`](doc/examples.md) — Practical examples and outputs

### For Developers

- [`calling_convention.md`](doc/calling_convention.md) — Details of the `__anrc64` calling convention
- [`naming_convention.md`](doc/naming_convention.md) — Naming scheme for functions, files, and symbols
* [`architecture.md`](doc/architecture.md) — Internal design, file layout, and logic flow

## License

Copyright © 2025 Anar Bastanov
Distributed under the [MIT License](http://www.opensource.org/licenses/mit-license.php)

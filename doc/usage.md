# Command-Line Usage

This document provides the full reference for all options supported by `qrgen`.

## Syntax

```
qrgen <text> [options]
qrgen -i <file> [options]
```

## Help (`--help`)

```
Input/Output:
  -i, --input <file>        Read input text from file or stdin (-)
  -o, --output <file>       Write result to file or stdout (-)
  -f, --format <txt|pbm|bin|hex|bits|c>
                            Output format (default: txt)

Encoding:
  -v, --version <1-40>      Force specific QR version
  -e, --eclevel <L|M|Q|H>   Error correction level (default: M)
  -m, --mode <byte|alnum|num>
                            Force encoding mode
  -k, --mask <0-7>          Force QR mask pattern
  -p, --pack <1|8|16>       Bits per module for raw output (default: 8)

Appearance:
  -S, --scale <n>           Scale each module by n (default: 1)
  -M, --margin <n>          Whitespace border in modules (default: 4)
  -I, --invert              Swap light/dark module representation

Rendering:
      --module-on <char>    Character for dark modules (default: ██)
      --module-off <char>   Character for light modules (default: space)

Display:
  -n, --info                Print QR matrix info before output
  -q, --quiet               Suppress non-essential output

Misc:
  -h, --help                Show this help message
  -H, --help-verbose        Show detailed option breakdown
      --lucky               ???
```

## Verbose Help (`--help-verbose`)

```
<text> is the main content to encode. If omitted, use --input to read from file or stdin.

Input/Output:
  -i, --input <file>
      Read input text from file. Use '-' for stdin.

  -o, --output <file>
      Write output to file. Use '-' for stdout.

  -f, --format txt
      Terminal text output (default)
  -f, --format pbm
      Monochrome image (Portable Bitmap P1 format)
  -f, --format bits
      Raw binary stream of module bits (bit-packed, no newlines)
  -f, --format hex
      Hexadecimal string form (e.g., FF00A1C2...)
  -f, --format bin
      Binary string form (e.g., 01001101...)
  -f, --format c
      Escaped byte stream for embedding (e.g., \\xFF\\x00)

Encoding:
  -v, --version <1-40>
      Use a specific QR version. Default: auto-selected based on input length.

  -e, --eclevel L
      Low error correction (~7% redundancy)
  -e, --eclevel M
      Medium error correction (~15%) [default]
  -e, --eclevel Q
      Quartile error correction (~25%)
  -e, --eclevel H
      High error correction (~30%)

  -m, --mode byte
      Byte mode (binary-safe UTF-8 or raw data)
  -m, --mode alnum
      Alphanumeric mode (A-Z, 0-9, and limited symbols)
  -m, --mode num
      Numeric mode (digits only)

  -k, --mask 0-7
      Use a fixed mask pattern (0-7). Default: auto-optimize.

  -p, --pack 1
      1 bit per module, fully packed into byte stream
  -p, --pack 8
      Each module stored in 1 byte (8 bits)
  -p, --pack 16
      Each module stored in 2 bytes (16 bits)

Appearance:
  -S, --scale <n>
      Each module is expanded to an n by n block. (default: 1)

  -M, --margin <n>
      Adds whitespace border of n modules around the QR. (default: 4)

  -I, --invert
      Inverts module polarity: dark <-> light (applies to all formats)

Rendering:
      --module-on <char>
          Character used to print dark modules (default: ██)

      --module-off <char>
          Character used to print light modules (default: space)

Display:
  -n, --info
      Print details: input length, version, size, mask used, error correction level, etc.

  -q, --quiet
      Suppress all non-error output, including --info

Miscellaneous:
  -h, --help
      Show summary of options

  -H, --help-verbose
      Show this full breakdown of flags and values

      --lucky
          ???
```

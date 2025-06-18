# `__anrc64` Calling Convention Specification

This document defines the `__anrc64` calling convention used across NASM-based x86-64 assembly projects. It specifies rules for argument passing, return value handling, stack management, and register preservation.

The convention is not ABI-compatible with any standard platform unless explicitly adapted (see [§5](#5-interoperability-with-c-libraries)). It is intended for internal use in low-level assembly projects and may evolve over time.

---

## 1. Argument Passing

### 1.1 Integer and Pointer Arguments

Integer and pointer arguments are passed in the following registers, in left-to-right order:

```
r8, r9, r10, r11, r12, r13
```

If a function accepts more than six integer or pointer arguments, then:

* The additional arguments **shall** be passed on the stack.
* These arguments **shall** be pushed in **right-to-left** order, such that the leftmost argument appears at the lowest memory address.
* All stack-passed arguments **shall** be pushed after all register-passed arguments.

If the size of any argument exceeds the width of a general-purpose register:

* The caller **shall** allocate memory for the argument.
* A pointer to the allocated memory **shall** be passed instead of the argument value.

A function **may** define a custom layout for oversized arguments across multiple registers. If so:

* This layout **shall** be documented in the function’s specification.

### 1.2 Floating-Point and SIMD Arguments

Floating-point and SIMD arguments are passed in the following registers, in order:

```
xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7
```

* These registers are used by default for scalar and 128-bit SIMD arguments.

Wider SIMD types (`ymm`, `zmm`) *may* be used instead of `xmm` if:

* The function explicitly documents such usage in its specification.

If a function requires more than seven floating-point or SIMD arguments:

* The remaining arguments *shall* be passed on the stack.

* Stack-passed SIMD arguments *shall* be placed after all integer arguments, regardless of source code ordering.

---

## 2. Return Values

### 2.1 Integer and Pointer Return Values

* Simple integer or pointer return values **shall** be returned in `rax`.
* If the return value spans multiple registers, the order shall be
`rdx:rcx:rbx:rax`, with `rax` holding the least significant bits.
* The number of registers used shall be documented in each function's specification.

If the return value is too large to fit in registers:

* The caller **shall** allocate memory for the result.
* A pointer to that memory **shall** be passed as the final argument.
* The callee **shall** write the result to this memory and return `void` in registers.

### 2.2 Floating-Point and SIMD Return Values

Scalar floating-point return values **shall** be returned in:

* `xmm0` for 128-bit or less,
* `ymm0` for 256-bit,
* `zmm0` for 512-bit.

Compound return values larger than one SIMD register:

* **Shall** follow the pointer-based return scheme from [§2.1](#21-integer-and-pointer-return-values).
* The memory **shall** be allocated by the caller and passed as the final argument.

If multiple floating-point values are returned (e.g., a pair of floats):

* The function **may** return them using multiple registers (e.g., `xmm0:xmm1`).
* Such behavior **must** be explicitly defined in the function’s specification.

---

## 3. Stack Management

* This convention imposes no fixed stack alignment requirement.

* The callee **may** realign the stack for performance, SIMD access, or ABI compliance.

* The caller **shall** clean up stack space used for extra arguments.

* Local variables **shall** be managed manually using standard stack operations:

  ```nasm
  sub rsp, N
  ; ...
  add rsp, N
  ```

* The value of `rsp` **shall** be the same before and after a function call unless stack memory is intentionally repurposed or leaked.

---

## 4. Register Usage and Preservation

### 4.1 General-Purpose Registers

| Register                                 | Convention                                                                                            |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `rax`, `rbx`, `rcx`, `rdx`, `rdi`, `rsi` | Volatile (caller-saved)                                                                               |
| `r8`, `r9`, `r10`, `r11`, `r12`, `r13`   | Preserved (callee-saved)                                                                              |
| `r14`                                    | Preserved (callee-saved); Commonly used with `rbp` for stack frame management                         |
| `r15`                                    | Reserved for interoperability (e.g., calling external C functions); **must not be modified manually** |
| `rbp`                                    | Preserved (callee-saved); recommended for stack frame management                                      |
| `rsp`                                    | Must be preserved; the stack pointer **shall** remain balanced                                        |

### 4.2 SIMD Registers

| Register Range        | Convention               |
| --------------------- | ------------------------ |
| `[xyz]mm1–[xyz]mm15`  | Volatile (caller-saved)  |
| `[xyz]mm16–[xyz]mm31` | Preserved (callee-saved) |

* On systems where AVX-512 is present and enabled, zmm16–zmm31 shall be treated as callee-preserved.
* On systems without AVX-512, their content is undefined after a function call.

---

## 5. Interoperability with C Libraries

When calling external C functions or interacting with other ABIs:

* The caller **shall** follow the external ABI’s rules for register usage, argument order, and stack alignment.
* The stack **must** be aligned as required by the callee before the function call.
* Wrapper functions **may** be used to convert between this convention and the target ABI.
* The `r15` register **may** be used in wrappers but must not be modified in regular functions.
* For this convention’s register behavior, see [§4.1](#41-general-purpose-registers) and [§4.2](#42-simd-registers).


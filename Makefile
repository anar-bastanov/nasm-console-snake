# Compiler and tools
CC := gcc
ASM := nasm

# Platform detection
ifeq ($(OS),Windows_NT)
    EXE := .exe
    DEL := del /Q
    MKDIR = if not exist $1 mkdir $1
    ASMFLAGS := -f win64 -dWINDOWS
else
    EXE :=
    DEL := rm -f
    MKDIR = mkdir -p $1
    ASMFLAGS := -f elf64 -dLINUX
endif

# Flags
CFLAGS := -Wall -O2
LDFLAGS :=

# Folders
SRC_DIR := src
BUILD_DIR := build
BIN_DIR := bin
TARGET := $(BIN_DIR)/snake$(EXE)

# Source files
CSOURCES := $(wildcard $(SRC_DIR)/*.c)
ASMSOURCES := $(wildcard $(SRC_DIR)/*.nasm)

# Object files
COBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(CSOURCES))
ASMOBJS := $(patsubst $(SRC_DIR)/%.nasm,$(BUILD_DIR)/%.o,$(ASMSOURCES))
OBJS := $(COBJS) $(ASMOBJS)

# Default target
all: $(TARGET)

# Ensure build/bin directories exist
$(BUILD_DIR):
	$(call MKDIR,$@)

$(BIN_DIR):
	$(call MKDIR,$@)

# Compile C source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble NASM source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.nasm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

# Link all object files
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

run: all
ifeq ($(OS),Windows_NT)
	cmd /c start "" "$(TARGET)"
else
	$(TARGET)
endif

# Clean build and binary files
clean:
ifeq ($(OS),Windows_NT)
	-@if exist $(BUILD_DIR) del /Q $(BUILD_DIR)\*.o
	-@if exist $(BIN_DIR) del /Q $(BIN_DIR)\*$(EXE)
else
	-$(DEL) $(BUILD_DIR)/*.o
	-$(DEL) $(BIN_DIR)/*$(EXE)
endif

.PHONY: all run clean

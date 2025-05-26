# ========== Directory ==========
SRC_DIR     := src
INCLUDE_DIR := include
BUILD_DIR   := build
BIN_DIR     := bin

# ========== Tools ==========
CC  := gcc
ASM := nasm

# ========== Platform Detection ==========
ifeq ($(OS),Windows_NT)
    EXE       := .exe
    DEL       := del /Q
    MKDIR     = if not exist $1 mkdir $1
    ASMFLAGS  := -f win64 -dWINDOWS -I$(INCLUDE_DIR)/
else
    EXE       :=
    DEL       := rm -f
    MKDIR     = mkdir -p $1
    ASMFLAGS  := -f elf64 -dLINUX -I$(INCLUDE_DIR)/
endif

# ========== Flags ==========
CFLAGS  := -Wall -O2
LDFLAGS :=

# ========== Derived ==========
CSOURCES   := $(wildcard $(SRC_DIR)/*.c)
ASMSOURCES := $(wildcard $(SRC_DIR)/*.nasm)
COBJS 	   := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(CSOURCES))
ASMOBJS    := $(patsubst $(SRC_DIR)/%.nasm,$(BUILD_DIR)/%.o,$(ASMSOURCES))
OBJS       := $(COBJS) $(ASMOBJS)
TARGET     := $(BIN_DIR)/snake$(EXE)

# ========== Default Target ==========
all: $(TARGET)

# ========== Directory Rules ==========
$(BUILD_DIR):
	$(call MKDIR,$@)

$(BIN_DIR):
	$(call MKDIR,$@)

# ========== C Compilation ==========
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ========== NASM Assembly ==========
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.nasm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

# ========== Linking ==========
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

# ========== Run Program ==========
run: all
ifeq ($(OS),Windows_NT)
	cmd /c start "" "$(TARGET)"
else
	$(TARGET)
endif

# ========== Clean Build Files ==========
clean:
ifeq ($(OS),Windows_NT)
	-$(DEL) "$(BUILD_DIR)\\*.o"
	-$(DEL) "$(BIN_DIR)\\*$(EXE)"
else
	-$(DEL) $(BUILD_DIR)/*.o
	-$(DEL) $(BIN_DIR)/*$(EXE)
endif

# ========== Phony Targets ==========
.PHONY: all run clean

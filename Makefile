ASM := nasm
ASMFLAGS := -f elf64 -I lib/
LD := ld

BUILD_DIR := build

ifeq ($(strip $(PROGRAM)),)
$(error Missing PROGRAM. Use: make PROGRAM=main)
endif

MAIN_SRC := $(PROGRAM).asm

LIB_SRCS := \
	lib/io.asm \
	lib/args.asm \
	lib/string.asm

MACROS := lib/macros.inc

SOURCES := $(MAIN_SRC) $(LIB_SRCS)
OBJECTS := $(SOURCES:%.asm=$(BUILD_DIR)/%.o)
TARGET := $(BUILD_DIR)/$(PROGRAM)

.PHONY: all clean rebuild

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: %.asm $(MACROS) | $(BUILD_DIR)
	@echo "running nasm on $<..."
	@mkdir -p $(dir $@)
	$(ASM) $(ASMFLAGS) $< -o $@

$(TARGET): $(OBJECTS)
	@echo "running linker..."
	$(LD) $(OBJECTS) -o $@

clean:
	rm -rf $(BUILD_DIR)

rebuild: clean all

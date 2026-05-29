ASM := nasm
ASMFLAGS := -f elf64
LD := ld

BUILD_DIR := build
.PHONY: all run clean rebuild

all: run

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: %.asm | $(BUILD_DIR)
	@echo "running nasm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)/%: $(BUILD_DIR)/%.o
	@echo "running linker..."
	$(LD) $< -o $@

run: $(BUILD_DIR)/$(PROGRAM)
	@echo "running program:"
	@echo "---"
	@./$(BUILD_DIR)/$(PROGRAM)
	@echo "---"

clean:
	rm -rf $(BUILD_DIR)

rebuild: clean run

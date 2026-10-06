SRC_DIR := src
OUT_DIR := out

SOURCES := $(wildcard $(SRC_DIR)/*.txt)
OUTPUTS := $(patsubst $(SRC_DIR)/%.txt,$(OUT_DIR)/%.txt,$(SOURCES))

.PHONY: all check build test clean ci

all: test

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/%.txt: $(SRC_DIR)/%.txt | $(OUT_DIR)
	@echo "BUILD $< -> $@"
	@tr '[:lower:]' '[:upper:]' < $< > $@

check:
	@if [ ! -d "$(SRC_DIR)" ]; then \
	echo "ERROR: Source directory missing"; \
	exit 1; \
	elif [ -z "$(SOURCES)" ]; then \
	echo "ERROR: No .txt files found"; \
	exit 1; \
	else \
	echo "CHECK PASSED: $(words $(SOURCES)) source files found"; \
	fi

build: $(OUTPUTS)

test: check build
	@if grep -l '[a-z]' $(OUTPUTS) >/dev/null 2>&1; then \
	echo "TEST FAILED: Lowercase characters found"; \
	exit 1; \
	else \
	echo "TEST PASSED"; \
	fi

clean:
	rm -rf $(OUT_DIR)

ci: clean check test

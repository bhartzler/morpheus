# Morpheus - Ancient Greek and Latin Morphological Analyzer
#
# Usage:
#   make       - Build everything (binaries + stemlib indices)
#   make bin   - Build and install binaries to bin/
#   make clean - Clean all build artifacts
#   make test  - Run basic tests

SRCDIR = src
BINDIR = bin
CRUNCHER = $(BINDIR)/cruncher

# Export PATH so stemlib builds can find the binaries
export PATH := $(CURDIR)/$(BINDIR):$(PATH)

# Export MORPHLIB for stemlib builds and cruncher
export MORPHLIB := $(CURDIR)/stemlib

all: bin greek latin

# Build and install binaries (skip if already built)
bin: $(BINDIR)/cruncher

$(BINDIR)/cruncher:
	@echo "=== Building Morpheus binaries ==="
	@$(MAKE) -C $(SRCDIR) --silent
	@$(MAKE) -C $(SRCDIR) install --silent

greek: bin
	@echo "=== Building Greek stemlib ==="
	@$(MAKE) -C stemlib/Greek > /dev/null 2>&1

latin: bin
	@echo "=== Building Latin stemlib ==="
	@$(MAKE) -C stemlib/Latin > /dev/null 2>&1

.PHONY: all bin greek latin clean test

clean:
	@echo "=== Cleaning ==="
	@rm -rf $(BINDIR)
	@$(MAKE) -C $(SRCDIR) clean --silent
	@$(MAKE) -C stemlib/Greek clean --silent
	@$(MAKE) -C stemlib/Latin clean --silent

test: all
	@echo "=== Testing ==="
	@echo "amo" | $(CRUNCHER) -L
	@echo "lo/gos" | $(CRUNCHER)
	@echo "=== OK ==="

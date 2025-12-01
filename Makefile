# Morpheus - Ancient Greek and Latin Morphological Analyzer
#
# Usage:
#   make          - Build everything (binaries + stemlib indices)
#   make binaries - Build just the core binaries
#   make stemlib  - Build the stemlib indices (requires binaries)
#   make clean    - Clean all build artifacts
#   make test     - Run basic tests
#
# Note: Italian stemlib exists but requires external SGML files not in this repo.

SRCDIR = src
CRUNCHER = $(SRCDIR)/anal/cruncher

# Export PATH so stemlib builds can find the binaries
export PATH := $(CURDIR)/$(SRCDIR)/gkends:$(CURDIR)/$(SRCDIR)/gkdict:$(CURDIR)/$(SRCDIR)/anal:$(CURDIR)/$(SRCDIR)/gener:$(PATH)

# Export MORPHLIB for stemlib builds and cruncher
export MORPHLIB := $(CURDIR)/stemlib

all: binaries greek latin

binaries:
	@echo "=== Building Morpheus binaries ==="
	@$(MAKE) -C $(SRCDIR) --silent

greek:
	@echo "=== Building Greek stemlib ==="
	@$(MAKE) -C stemlib/Greek > /dev/null 2>&1

latin:
	@echo "=== Building Latin stemlib ==="
	@$(MAKE) -C stemlib/Latin > /dev/null 2>&1

# Verbose pass-through for debugging (e.g., make greek-nends)
greek-%:
	$(MAKE) -C stemlib/Greek $*

latin-%:
	$(MAKE) -C stemlib/Latin $*

.PHONY: all binaries greek latin clean test

clean:
	@echo "=== Cleaning src ==="
	$(MAKE) -C $(SRCDIR) clean
	@echo "=== Cleaning stemlib/Greek ==="
	$(MAKE) -C stemlib/Greek clean
	@echo "=== Cleaning stemlib/Latin ==="
	$(MAKE) -C stemlib/Latin clean

test: all
	@echo "=== Testing Latin ==="
	@echo "amo" | $(CRUNCHER) -L
	@echo "=== Testing Greek ==="
	@echo "lo/gos" | $(CRUNCHER)
	@echo "=== All tests passed ==="

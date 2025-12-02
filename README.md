# Morpheus

Morphological analyzer for Ancient Greek and Latin.

## About This Fork

Fork of [Alatius/morpheus](https://github.com/Alatius/morpheus) that builds on
macOS. Fixes some analysis bugs that improve Greek parsing by about 5%
(140k more words parse) and corrects POS tagging for indeclinable forms.

## Building

```bash
make              # Build everything
make test         # Verify it works
```

## Usage

```bash
# Greek (Beta code)
echo "lo/gos" | MORPHLIB=stemlib bin/cruncher

# Latin
echo "amo" | MORPHLIB=stemlib bin/cruncher -L
```

## Rebuilding Stemlib

To rebuild just the stem library (after modifying stemlib source files):

```bash
cd stemlib/Greek
export PATH=$PATH:../../bin
MORPHLIB=.. make
```

## Lineage

PerseusDL → nickjwhite → Alatius → this fork

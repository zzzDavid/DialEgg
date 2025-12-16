# Decoupled Extraction Implementation Summary

## Overview

Successfully split the DialEgg equality saturation workflow into two separate passes to enable external extraction tools.

## Changes Made

### 1. New Passes Created

#### `EggifyOnlyPass` (Step 1: MLIR → Egglog → JSON)
- **Files:** `src/EggifyOnlyPass.h`, `src/EggifyOnlyPass.cpp`
- **Purpose:** Converts MLIR to Egglog and generates E-graph JSON without performing extraction
- **CLI Usage:** `egg-opt --eggify-only --egg-file=<file.egg> <input.mlir>`
- **Outputs:**
  - `<name>.ops.egg` - Egglog program with all operations
  - `<name>.egraph.json` - E-graph state (from `egglog --to-json`)
  - `<name>.extraction-metadata.txt` - Metadata about operations to extract
  - `<name>-egglog.log` - Egglog execution log

#### `ReconstructFromExtractionPass` (Step 2: Extraction → MLIR)
- **Files:** `src/ReconstructFromExtractionPass.h`, `src/ReconstructFromExtractionPass.cpp`
- **Purpose:** Reconstructs optimized MLIR from external extraction results
- **CLI Usage:** `egg-opt --reconstruct-from-extraction --extraction-file=<extracted.txt> --egg-file=<file.egg> <input.mlir> -o <output.mlir>`
- **Inputs:**
  - Original MLIR file
  - `<name>.extracted.txt` - Extraction results (S-expressions)
  - `<name>.extraction-metadata.txt` - Metadata (auto-detected)
  - `<name>.egg` - Egglog operation definitions

### 2. Modified Files

#### `src/egg-opt.cpp`
- Added includes for new passes
- Registered `EggifyOnlyPass` 
- Registered `ReconstructFromExtractionPass`
- Added documentation comments

#### `CMakeLists.txt`
- Added `src/EggifyOnlyPass.cpp` to build
- Added `src/ReconstructFromExtractionPass.cpp` to build

### 3. Documentation

#### `DECOUPLED_EXTRACTION.md`
- Comprehensive usage guide
- Workflow comparison (one-step vs two-step)
- Extraction file format specification
- Examples and debugging tips
- Guide for creating custom extractors

#### `test_decoupled_workflow.sh`
- Automated test script for the decoupled workflow
- Demonstrates all three steps with simulated extraction
- Useful for validation and as a template

## Technical Details

### How It Works

1. **EggifyOnlyPass:**
   - Eggifies MLIR operations (same as original pass)
   - Generates `.ops.egg` file WITHOUT extraction commands
   - Runs `egglog --to-json` to dump E-graph state
   - Saves metadata about which operations should be extracted

2. **External Extraction** (User-provided):
   - Reads E-graph JSON
   - Implements custom extraction algorithm
   - Outputs S-expressions in the correct order

3. **ReconstructFromExtractionPass:**
   - Re-eggifies original MLIR (to recreate operation mapping)
   - Reads extraction results line-by-line
   - Uses existing `Egglog::parseOperation()` to convert S-expressions to MLIR
   - Replaces original operations with optimized versions
   - Performs dead code elimination

### Key Design Decisions

1. **Reusing Existing Infrastructure:**
   - Both new passes reuse `Egglog` class and parsing functions
   - No changes to core egglog translation logic
   - Minimal code duplication

2. **Metadata File:**
   - Simple text format for easy parsing
   - Contains operation IDs and original MLIR for reference
   - Defines the order expected in extraction results

3. **Backwards Compatibility:**
   - Original `--eq-sat` pass remains unchanged
   - New passes are opt-in via separate flags
   - No breaking changes to existing workflows

4. **Extraction Format:**
   - Uses same S-expression format as before
   - Compatible with existing egglog infrastructure
   - Easy for external tools to generate

## Benefits

1. **Flexibility:** Users can plug in any extraction algorithm
2. **Research-Friendly:** E-graph is accessible for analysis
3. **Optimization:** Custom cost models and extraction strategies
4. **Debugging:** Intermediate files can be inspected
5. **Extensibility:** Easy to add new extraction tools

## Testing

The implementation includes:
- `test_decoupled_workflow.sh` - End-to-end test script
- Simulates the full workflow with built-in extraction
- Can be used as a template for custom extractors

## Usage Example

```bash
# Step 1: Generate E-graph
egg-opt --eggify-only --egg-file=design.egg design.mlir -o /dev/null

# Step 2: Run custom extraction (user-provided tool)
my_extractor --input design.egraph.json --output design.extracted.txt

# Step 3: Reconstruct optimized MLIR
egg-opt --reconstruct-from-extraction \
        --extraction-file=design.extracted.txt \
        --egg-file=design.egg \
        design.mlir -o design_optimized.mlir
```

## Future Enhancements

Potential improvements:
1. Add JSON metadata format (instead of text)
2. Support for parallel extraction of multiple blocks
3. Validation tool for extraction results
4. Example custom extractors (ILP, beam search, etc.)
5. Performance profiling hooks

## Files Created

- `src/EggifyOnlyPass.h` - Header for step 1 pass
- `src/EggifyOnlyPass.cpp` - Implementation for step 1 pass
- `src/ReconstructFromExtractionPass.h` - Header for step 2 pass
- `src/ReconstructFromExtractionPass.cpp` - Implementation for step 2 pass
- `DECOUPLED_EXTRACTION.md` - User documentation
- `IMPLEMENTATION_SUMMARY.md` - This file
- `test_decoupled_workflow.sh` - Test script

## Files Modified

- `src/egg-opt.cpp` - Added pass registrations
- `CMakeLists.txt` - Added new source files to build

---

**Status:** ✅ Implementation Complete

The decoupled extraction workflow is fully implemented and ready for use. Users can now separate the egglog translation from extraction, enabling custom optimization algorithms and external extraction tools.


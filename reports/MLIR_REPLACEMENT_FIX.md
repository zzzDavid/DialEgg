## MLIR Replacement Fix for comparator_4bit (2025-12-16)

### Overview
- **Problem**: After reconstruction, `comparator_4bit_optimized.mlir` still contained the old logic plus the new optimized logic. The original comparator chain was not removed; outputs were driven by new regs, but dead ops remained, bloating the IR and Verilog.
- **Scope**: DialEgg reconstruction path (`ReconstructFromExtractionPass`), triggered via `run_eqsat.sh` + `run_extract_translate.sh` in `test/replacement/`.

### Reproduction
1) From `dialegg/test/replacement/` run:
   - `bash run_eqsat.sh`
   - `bash run_extract_translate.sh`
2) Observe `comparator_4bit_optimized.mlir` contained both the old subtract/diff path and the new direct compares (before fix).

### Root Cause
- The reconstruction pass iterated over extractable ops but **stopped after the first one** due to an early `break`. Only `hw.output` was replaced; other ops stayed unchanged.
- Dead/unused ops were not aggressively removed; the pass relied only on `isOpTriviallyDead`, so side-effectful ops with no uses could remain.

### Fixes (code)
1) **Reconstruct all extractable ops** (remove early break):
   - File: `src/ReconstructFromExtractionPass.cpp`
   - Logic: loop over all `egglog.eggifiedBlock` entries that `shouldBeExtracted()`, reading each extraction line and replacing/erasing the MLIR op. No early exit.

2) **Aggressive cleanup of unused ops**:
   - File: `src/ReconstructFromExtractionPass.cpp`
   - Logic: dead-code sweep now also erases ops whose results have no uses (`unusedResults`), in addition to trivially-dead ops and dead function calls. This removes the old comparator chain once outputs are rewired.

### Result
- `comparator_4bit_optimized.mlir` now contains only the optimized comparator (direct compares), with the old subtract/diff chain removed. The module is minimal and matches the extracted intent.

### Commands run
- Build: `rm -rf build-release && mkdir build-release && cd build-release && cmake .. -DCMAKE_BUILD_TYPE=Release -DLLVM_DIR=/work/global/aspen/circt/llvm/build/lib/cmake/llvm -DMLIR_DIR=/work/global/aspen/circt/llvm/build/lib/cmake/mlir && cmake --build .`
- Tests: from `test/replacement/`
  - `bash run_eqsat.sh`
  - `bash run_extract_translate.sh`

### Files touched
- `src/ReconstructFromExtractionPass.cpp`
  - Remove early break; process all extractable ops
  - Add unused-result cleanup in DCE loop

### Remaining considerations
- The DCE step now removes any op with unused results, even if side-effectful; current HW/SEQ patterns are safe, but if future dialect ops rely on side effects without uses, we may need a dialect-aware filter.
- If multiple blocks are present, ensure extraction file ordering matches block order (unchanged behavior, but worth noting).

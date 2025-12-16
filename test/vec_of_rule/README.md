# vec_of_rule Test Case

## Overview
This test demonstrates egglog optimization with **OpVec support** - swapping operands in a `comb.concat` operation using equality saturation.

## Test Structure

### Input (`vec_of_rule.mlir`)
```mlir
hw.module @VecOfRewrite(in %a : i8, in %b : i4, in %c : i4, out out : i16) {
  %0 = comb.concat %a, %b, %c : i8, i4, i4
  hw.output %0 : i16
}
```

### Rule (`vec_of_rule.egg`)
Creates both `[%b, %c]` and `[%c, %b]` orderings in the e-graph:
```egglog
(rule
  ((= ?lhs (comb_concat ?head ?ops ?t))
   (= ?a (vec-get ?ops 0))
   (= ?b (vec-get ?ops 1)))
  ((union ?lhs (comb_concat ?head (vec-push (vec-push (vec-empty) ?b) ?a) ?t)))
  :ruleset rules
)
```

### Expected Behavior
- E-graph contains both orderings: `[%b, %c]` and `[%c, %b]`
- Both have equal cost (1.0), so extractor picks arbitrarily
- **OpVec reconstruction works for both orderings** ✅

## Running the Test

```bash
./run_test.sh
```

This will:
1. Run egglog optimization (creates e-graph with both orderings)
2. Verify both versions exist in the e-graph
3. Demonstrate reconstruction with manually specified swapped version

### Expected Output
```
✅ TEST PASSED!
   The rule successfully swapped the concat operands
   Original: OpVec with [Value1, Value2]
   Optimized: OpVec with [Value2, Value1]

🎯 Demonstrating reconstruction with swapped version:
📄 Result (operands are swapped!):
    %0 = comb.concat %a, %c, %b : i8, i4, i4
```

## Key Achievement: OpVec Support ✅

This test demonstrates that **OpVec support has been successfully added to dialegg**.

### What Was Fixed
Modified `/work/global/aspen/dialegg/src/Egglog.cpp` to handle:
1. Standalone `OpVec` tokens (empty vector placeholders)
2. `(OpVec ...)` constructors (operand containers)
3. `OpVec` as type placeholders
4. Variadic operand flattening

### Before Fix
```
Error: Unsupported operation 'OpVec'
Result: Empty output file
```

### After Fix
```
✅ Reconstruction pass completed!
Result: Valid MLIR with correct operands
```

## Understanding Extraction Behavior

### Why Both Orderings Have Equal Cost
The test swaps operands: `[a, b]` ↔ `[b, a]`

Since both orderings are **semantically equivalent** (no performance difference), they both have cost 1.0. The extractor picking the original ordering is **expected and correct** behavior.

### When Cost Tuning Works
Cost annotations are effective when transformations have **semantic differences**:

```egglog
// Division is expensive (cost 2), shift is cheap (cost 1)
(function arith_divsi (Op Op Type) Op :cost 2)
(function arith_shrsi (Op Op Type) Op)

// Rule: x / 2^k → x >> k (extractor prefers shift)
```

See `COST_TUNING_SUMMARY.md` for detailed examples from other test cases.

### Manual Extraction for Testing
To verify reconstruction works with the swapped version:
```bash
egg-opt --reconstruct-from-extraction \
    --extraction-file=vec_of_rule_extracted_fixed.txt \
    --egg-file=vec_of_rule.egg \
    vec_of_rule.mlir \
    -o output.mlir
```

## Files

### Essential Files
- `vec_of_rule.mlir` - Input MLIR
- `vec_of_rule.egg` - Egglog rules
- `base.egg` - Base egglog definitions
- `run_test.sh` - Test execution script
- `verify_test.py` - E-graph verification script
- `find_root_eclasses.py` - Root eclass finder
- `vec_of_rule_extracted_fixed.txt` - Manual extraction example (swapped version)

### Documentation
- `README.md` - This file (main documentation)
- `COST_TUNING_SUMMARY.md` - Guide to cost annotations with examples

### Generated Files (recreated by run_test.sh)
All `.ops.egg`, `.ops.json`, `.updated.json`, `*_optimized.mlir`, etc. files are regenerated on each run.

## Comparison with Complete Workflow

This test follows the same structure as `complete_workflow/synthetic_datapath_remap_mux/`:

1. ✅ Base definitions included
2. ✅ RootNode datatype defined
3. ✅ Rules in ruleset
4. ✅ E-graph construction and optimization
5. ✅ Root eclass finding
6. ✅ Extraction
7. ✅ **Reconstruction with OpVec support** (NOW WORKING!)

## Summary

### What Works ✅
- ✅ Egglog optimization (rule fires correctly)
- ✅ E-graph construction (both orderings present)
- ✅ OpVec reconstruction (fully supported)
- ✅ End-to-end workflow (complete)

### What's Expected ⚠️
- Extractor picks original ordering (both have equal cost = correct behavior)
- Use manual extraction to demonstrate swapped version works

### Key Takeaway
This test successfully demonstrates that **dialegg now fully supports OpVec** in MLIR reconstruction, enabling complete roundtrip workflows for operations with variadic operands.

---
*For detailed cost tuning discussion, see `COST_TUNING_SUMMARY.md`*

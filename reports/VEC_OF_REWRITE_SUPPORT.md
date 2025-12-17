# DialEgg Vec-of Rewrite Support

## Overview

DialEgg supports rewrite rules over variadic operands using egglog's built-in `Vec` sort. This enables pattern matching and transformation of MLIR operations with variable numbers of operands, such as `comb.concat`, `comb.and`, `comb.or`, and similar operations.

## Core Concept: OpVec

In DialEgg's egglog representation, variadic operands are modeled using the `OpVec` sort:

```egglog
;; From base.egg
(sort OpVec (Vec Op))
```

Operations with variadic operands are declared with `OpVec` as a parameter:

```egglog
;; Operations with variadic operands
(function comb_concat (Op OpVec Type) Op)
(function comb_and (Op OpVec Type) Op)
(function comb_or (Op OpVec Type) Op)
(function hw_output (Op OpVec) Op)
```

## How OpVec Works

### 1. Serialization (MLIR → Egglog)

When DialEgg converts an MLIR operation to egglog, variadic operands are serialized using `vec-push` chains:

**MLIR Input:**
```mlir
%0 = comb.concat %a, %b, %c : i8, i4, i4
```

**Egglog Representation:**
```egglog
(let op0 (Value 0 (I8)))   ; %a
(let op1 (Value 1 (I4)))   ; %b  
(let op2 (Value 2 (I4)))   ; %c
(let op3 (comb_concat op0 (vec-push (vec-push (vec-empty) op1) op2) (I16)))
```

The C++ code in `Egglog.cpp` builds the vector incrementally:

```cpp
// From eggifyOperation() in Egglog.cpp
if (egglogOpDef.hasVariadicOperands && egglogOpDef.usesOpVec) {
    std::string acc = "(vec-empty)";
    for (size_t i = fixed; i < operandCount; i++) {
        EggifiedOp* eggifiedOperand = eggifyValue(op->getOperand(i));
        acc = "(vec-push " + acc + " " + eggifiedOperand->getPrintId() + ")";
    }
    ss << " " << acc;
}
```

### 2. Pattern Matching in Rules

Egglog's built-in vector operations enable powerful pattern matching:

| Operation | Description | Example |
|-----------|-------------|---------|
| `(vec-get ?ops n)` | Get nth element | `(= ?a (vec-get ?ops 0))` |
| `(vec-push ?vec ?elem)` | Append element | `(vec-push (vec-empty) ?x)` |
| `(vec-empty)` | Empty vector | Base case for construction |
| `(vec-of ?a ?b ...)` | Vector literal | `(vec-of ?a ?b ?c)` |

### 3. Reconstruction (Egglog → MLIR)

During reconstruction, DialEgg parses vector expressions and flattens them back into MLIR operands:

```cpp
// From parseOperation() in Egglog.cpp
std::function<void(std::string_view)> flattenOpVec = [&](std::string_view vecExpr) {
    std::vector<std::string_view> vecSplit = splitExpression(vecExpr);
    std::string_view head = vecSplit[0];
    
    if (head == "vec-of") {
        for (size_t vi = 1; vi < vecSplit.size(); vi++) {
            flattenOpVec(vecSplit[vi]);
        }
    } else if (head == "vec-push" || head == "opvec-push") {
        flattenOpVec(vecSplit[1]);  // Recursively process base
        flattenOpVec(vecSplit[2]);  // Then the pushed element
    } else if (head == "vec-empty" || head == "opvec-empty") {
        return;  // Base case - no operands
    } else {
        // Parse as operand and add to operands list
        // ...
    }
};
```

## Example: Operand Swapping Rule

The `vec_of_rule` test demonstrates a rule that swaps two operands in a concat operation:

### Test Input (`vec_of_rule.mlir`)
```mlir
hw.module @VecOfRewrite(in %a : i8, in %b : i4, in %c : i4, out out : i16) {
  %0 = comb.concat %a, %b, %c : i8, i4, i4
  hw.output %0 : i16
}
```

### Rewrite Rule (`vec_of_rule.egg`)
```egglog
(rule
  ((= ?lhs (comb_concat ?head ?ops ?t))
   (= ?a (vec-get ?ops 0))    ; Get first variadic operand
   (= ?b (vec-get ?ops 1)))   ; Get second variadic operand
  ((union ?lhs (comb_concat ?head 
    (vec-push (vec-push (vec-empty) ?b) ?a)  ; Swapped: [b, a] instead of [a, b]
    ?t)))
  :ruleset rules
)
```

### What This Rule Does

1. **Pattern Match**: Finds any `comb_concat` with at least 2 variadic operands
2. **Extract Elements**: Binds `?a` to first operand, `?b` to second
3. **Create Alternative**: Constructs a new concat with swapped operands `[b, a]`
4. **Union**: Adds both orderings to the same e-class

### E-Graph Result

After saturation, the e-graph contains both orderings:

```
E-class for concat result:
├── (comb_concat op0 (vec-push (vec-push (vec-empty) op1) op2) (I16))  ; Original [b, c]
└── (comb_concat op0 (vec-push (vec-push (vec-empty) op2) op1) (I16))  ; Swapped [c, b]
```

### Reconstructed Output
```mlir
%0 = comb.concat %a, %c, %b : i8, i4, i4   ; Operands swapped!
```

## Advanced Usage: Multiple Operand Patterns

### Matching Specific Operand Counts

```egglog
;; Rule that only matches concat with exactly 2 variadic operands
(rule
  ((= ?lhs (comb_concat ?head ?ops ?t))
   (= ?a (vec-get ?ops 0))
   (= ?b (vec-get ?ops 1))
   (!= ?ops (vec-push (vec-push (vec-push (vec-empty) _) _) _)))  ; Exclude 3+ operands
  ((union ?lhs (optimized_concat ?head ?a ?b ?t)))
  :ruleset rules
)
```

### Accumulating Over Operands

For operations like multi-input AND/OR gates:

```egglog
;; Merge nested AND operations
(rule
  ((= ?lhs (comb_and ?head1 ?ops1 ?t))
   (= ?nested (vec-get ?ops1 0))
   (= ?nested (comb_and ?head2 ?ops2 ?t)))
  ;; Flatten: AND(x, AND(y, z)) → AND(x, y, z)
  ((union ?lhs (comb_and ?head1 (vec-push ?ops2 (vec-get ?ops1 1)) ?t)))
  :ruleset rules
)
```

## Workflow Summary

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    MLIR     │ ──▶ │   Egglog    │ ──▶ │   E-graph   │ ──▶ │    MLIR     │
│   Input     │     │   (OpVec)   │     │  (Equiv)    │     │   Output    │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
                          │                   │
                          │   vec-push        │   Extraction
                          │   vec-get         │   chooses best
                          │   vec-empty       │   representation
                          ▼                   ▼
                    ┌─────────────────────────────┐
                    │  Rules match & transform    │
                    │  variadic operand patterns  │
                    └─────────────────────────────┘
```

## Running the Example

```bash
cd /work/global/aspen/dialegg/test/vec_of_rule
./run_test.sh
```

Expected output:
```
✅ TEST PASSED!
   The rule successfully swapped the concat operands
   Original: OpVec with [Value1, Value2]
   Optimized: OpVec with [Value2, Value1]

🎯 Demonstrating reconstruction with swapped version:
📄 Result (operands are swapped!):
    %0 = comb.concat %a, %c, %b : i8, i4, i4
```

## Key Implementation Details

### Files Modified for OpVec Support

1. **`Egglog.cpp`** - Core serialization/deserialization
   - `eggifyOperation()`: Serialize variadic ops with `vec-push` chains
   - `parseOperation()`: Flatten `vec-push`/`vec-of` back to operands
   - Handle standalone `OpVec` tokens as empty vectors

2. **`Egglog.h`** - Operation definition parsing
   - `EgglogOpDef::usesOpVec`: Track if operation uses OpVec
   - `EgglogOpDef::hasVariadicOperands`: Variadic support flag

### Supported Vector Operations

| Egglog Syntax | Meaning |
|---------------|---------|
| `(vec-empty)` | Empty vector `[]` |
| `(vec-push ?v ?x)` | Append: `v ++ [x]` |
| `(vec-get ?v n)` | Index: `v[n]` |
| `(vec-of ?a ?b ?c)` | Literal: `[a, b, c]` |
| `(vec-length ?v)` | Length of vector |

## Cost Considerations

When both original and transformed versions have equal cost, the extractor chooses arbitrarily. Use cost annotations when there's a semantic preference:

```egglog
;; Expensive operation
(function expensive_concat (Op OpVec Type) Op :cost 100)

;; Cheap operation  
(function cheap_op (Op Op Type) Op :cost 1)

;; Extractor will prefer cheap_op when both are equivalent
```

For symmetric transformations (like operand swapping where both are equally valid), either result is correct.

## Summary

DialEgg's OpVec support enables:

- ✅ Pattern matching over variadic operands
- ✅ Constructing new operand orderings in rules
- ✅ Full roundtrip: MLIR → Egglog → E-graph → MLIR
- ✅ Integration with egglog's native `Vec` sort operations

This makes DialEgg capable of expressing and optimizing a wide range of hardware operations with variable numbers of inputs.

---

*Related documentation:*
- `test/vec_of_rule/README.md` - Test case details
- `test/vec_of_rule/COST_TUNING_SUMMARY.md` - Cost annotation guide
- `reports/IMPLEMENTATION_SUMMARY.md` - Overall DialEgg architecture


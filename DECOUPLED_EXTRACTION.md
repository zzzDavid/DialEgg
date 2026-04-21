# Decoupled Extraction Workflow

This document explains how to use the new two-step workflow for separating egglog translation from extraction.

## Overview

Previously, DialEgg performed everything in one pass:
```
MLIR → Egglog → Extraction → MLIR
```

Now, you can split this into two separate steps:

### Step 1: Eggify Only (MLIR → Egglog → E-graph JSON)
```
MLIR → Egglog E-graph (JSON)
```

### Step 2: Reconstruct from Extraction (Extraction results → MLIR)
```
Extraction results → MLIR
```

This allows you to use **external extraction tools** (e.g., custom extractors, optimization algorithms) between Step 1 and Step 2.

---

## Usage

### Option 1: Original Workflow (One-Step)

The original `--eq-sat` pass still works:

```bash
egg-opt --eq-sat --egg-file=design.egg design.mlir -o design_optimized.mlir
```

This runs the full pipeline in one go.

---

### Option 2: Decoupled Workflow (Two-Step)

#### Step 1: Generate E-graph JSON

```bash
egg-opt --eggify-only --egg-file=design.egg design.mlir -o design_ignored.mlir
```

**Outputs:**
- `design.ops.egg` - The egglog program with all operations
- `design.egraph.json` - The E-graph state in JSON format (from `egglog --to-json`)
- `design.extraction-metadata.txt` - Metadata about which operations should be extracted
- `design-egglog.log` - Egglog execution log

**Note:** The `-o design_ignored.mlir` output will be the same as the input since no transformations are applied in this step.

#### Step 2: Run External Extraction

Now you can run your **external extraction tool** on `design.egraph.json`. Your extractor should:

1. Read `design.egraph.json` (the E-graph state)
2. Read `design.extraction-metadata.txt` to see which operations need extraction
3. Perform extraction using your custom algorithm
4. Output extraction results to `design.extracted.txt`

The extraction results file should contain **S-expressions**, one per line, in the **same order** as listed in the metadata file.

**Example extraction result format (`design.extracted.txt`):**
```
(comb_mux (Value 7 I1-0) (comb_concat ...) (comb_concat ...) I16-0)
(seq_firreg (Value 1342 I64-0) (seq_to_clock ...) ...)
(Value 42 I32-0)
...
```

#### Step 3: Reconstruct MLIR from Extraction

```bash
egg-opt --reconstruct-from-extraction --extraction-file=design.extracted.txt --egg-file=design.egg design.mlir -o design_optimized.mlir
```

**Inputs:**
- `design.mlir` - Original MLIR file
- `design.extracted.txt` - Extraction results (S-expressions)
- `design.extraction-metadata.txt` - Metadata (automatically found)
- `design.egg` - Egglog operation definitions

**Output:**
- `design_optimized.mlir` - Optimized MLIR with extracted operations

---

## Extraction File Format

Your external extractor must produce a text file with **one S-expression per line**, matching the order in the metadata file.

### S-expression Format

S-expressions follow the egglog syntax:

```
(<op_name> <operand1> <operand2> ... <attr1> <attr2> ... <type>)
```

**Examples:**

1. **Simple operation:**
   ```
   (comb_and (Value 5 I64-0) (Value 6 I64-0) I64-0)
   ```

2. **Nested operations:**
   ```
   (comb_mux (Value 7 I1-0) (comb_concat (Value 10 I8-0) (Value 11 I8-0) I16-0) (Value 12 I16-0) I16-0)
   ```

3. **Opaque value (no operation):**
   ```
   (Value 42 I32-0)
   ```

### Key Points:

- **Operands** can be:
  - Value references: `(Value <id> <type>)`
  - Nested operations: `(op_name ...)`
  
- **Attributes** use the format: `(NamedAttr "name" <attr_value>)`

- **Types** are specified at the end (e.g., `I64-0`, `I32-0`, `(RankedTensor ...)`)

---

## Example Workflow

### Full Example: Data Shuffle Optimization

```bash
# Step 1: Generate E-graph
egg-opt --eggify-only --egg-file=data_shuffle.egg data_shuffle.mlir -o /dev/null

# Step 2: Run custom extraction tool
my_custom_extractor --input data_shuffle.egraph.json \
                     --metadata data_shuffle.extraction-metadata.txt \
                     --output data_shuffle.extracted.txt

# Step 3: Reconstruct optimized MLIR
egg-opt --reconstruct-from-extraction \
        --extraction-file=data_shuffle.extracted.txt \
        --egg-file=data_shuffle.egg \
        data_shuffle.mlir \
        -o data_shuffle_optimized.mlir
```

---

## Understanding the Metadata File

The `*.extraction-metadata.txt` file contains information about which operations need to be extracted:

```
BLOCK: main_func.func
op42    %1 = comb.mux %0, %2, %3 : i16
op57    %4 = seq.firreg %5 clock %clk : i64
END_BLOCK
```

- **BLOCK:** Identifies the block being processed
- **opN:** The operation ID (e.g., `op42`)
- Followed by the original MLIR operation for reference
- **END_BLOCK:** Marks the end of the block

Your extraction results must provide S-expressions **in the same order** as these operations appear.

---

## Comparison with Original Workflow

| Feature | Original (`--eq-sat`) | Decoupled (`--eggify-only` + `--reconstruct`) |
|---------|----------------------|----------------------------------------------|
| **Extraction** | Built-in egglog extraction | External custom extraction |
| **Flexibility** | Fixed extraction algorithm | Use any extraction tool |
| **Steps** | Single pass | Two passes |
| **E-graph access** | Not directly accessible | JSON export available |
| **Use case** | Quick optimization | Research, custom extractors |

---

## Debugging Tips

1. **Check metadata file** to see which operations are being extracted
2. **Compare line counts**: Your `*.extracted.txt` should have the same number of lines as operations listed in the metadata
3. **Use `--debug` flag** to see detailed egglog output
4. **Verify S-expression syntax** by looking at `*.ops.egg` for examples

---

## Advanced: Creating Custom Extractors

Your custom extractor should:

1. **Parse the E-graph JSON** (`*.egraph.json`)
2. **Read metadata** to identify which operations to extract
3. **Implement extraction logic** (e.g., greedy, ILP, custom cost model)
4. **Output S-expressions** in the correct order

The E-graph JSON format follows the egglog `--to-json` specification. See the [egglog documentation](https://github.com/egraphs-good/egglog) for details.

---

## Questions?

If you encounter issues:
- Check that your extraction file has the correct number of lines
- Verify S-expression syntax matches the examples
- Ensure all `Value` references point to existing operations
- Check the `-egglog.log` file for egglog errors


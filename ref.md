## print stuff
```cpp
// print attributes and their values
llvm::outs() << "Attributes: ";
mlir::DictionaryAttr attrs = op.getAttrDictionary();
for (const mlir::NamedAttribute& attr : attrs) {
    llvm::outs() << attr.getName() << " = " << attrs.get(attr.getName()) << "  ";
}
llvm::outs() << "\n";
```
```cpp
// print region
if (!op.getRegions().empty()) {
    llvm::outs() << "Region: ";
    std::for_each(op.getRegion(0).begin(), op.getRegion(0).end(), [](mlir::Block& block) {
        block.print(llvm::outs());
    });
    llvm::outs() << "\n\n\n";
}
```

## mlir-opt flags
### Flags for tensor ops
```bash
--convert-elementwise-to-linalg
--convert-tensor-to-linalg
--one-shot-bufferize=bufferize-function-boundaries=true
--convert-linalg-to-loops
--expand-strided-metadata
--lower-affine
--convert-index-to-llvm
--convert-scf-to-cf
--convert-cf-to-llvm
--convert-arith-to-llvm
--convert-func-to-llvm
--finalizing-bufferize
--finalize-memref-to-llvm
--reconcile-unrealized-casts
```

## egglog
### Arith example
```egglog
(sort Attr)
(sort AttrDict (Map String Attr))
(sort AttrVec (Vec Attr))
; (sort AttrPair (Tuple String Attr)) ; ERROR: "Presort Tuple not found."

(function UnitAttr () Attr) 
(function IntAttr (i64 String) Attr) 
(function FloatAttr (f64 String) Attr)
(function StringAttr (String) Attr)
(function ArrayAttr (AttrVec) Attr)
(function OtherAttr (String String) Attr)

(datatype Op
	(arith_constant Attr String)

	(arith_addf Op Op Attr String)
	(arith_subf Op Op Attr String)
	(arith_divf Op Op Attr String)
	(arith_mulf Op Op Attr String)
	(arith_negf Op Attr String)

	(arith_maximumf Op Op Attr String)
   	(arith_minimumf Op Op Attr String)
)

(let one (arith_constant (FloatAttr 1.0 "f64") "f64"))
(let two (arith_constant (FloatAttr 2.0 "f64") "f64"))

(let one_addf_two (arith_addf one two (StringAttr "none") "f64"))
(let one_mulf_two (arith_mulf one two (StringAttr "none") "f64"))
(let negf_two (arith_negf two (StringAttr "none") "f64"))

(rewrite ; constant fold for addf
	(arith_addf (arith_constant (FloatAttr ?x ?t) ?t) (arith_constant (FloatAttr ?y ?t) ?t) ?a ?t)
 	(arith_constant (FloatAttr (+ ?x ?y) ?t) ?t)
)

(rewrite ; constant fold for mulf
	(arith_mulf (arith_constant (FloatAttr ?x ?t) ?t) (arith_constant (FloatAttr ?y ?t) ?t) ?a ?t)
 	(arith_constant (FloatAttr (* ?x ?y) ?t) ?t)
)

(rewrite ; constant fold for negf
	(arith_negf (arith_constant (FloatAttr ?x ?t) ?t) ?a ?t)
 	(arith_constant (FloatAttr (neg ?x) ?t) ?t)
)

(rewrite ; commute
	(arith_addf ?x ?y ?a ?t)
	(arith_addf ?y ?x ?a ?t)
)

(run 10)

(extract one_addf_two)
(extract one_mulf_two)
(extract negf_two)
```
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

## Print all ops in all registered dialects:
```cpp
#include <fstream>
#include <iostream>
#include "mlir/InitAllDialects.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"

int main() {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();

    size_t mostAttributes = 0;
    std::string opWithMostAttributes;
    std::ofstream file("res/mlir/all-ops.txt");

    llvm::ArrayRef<mlir::RegisteredOperationName> allOps = context.getRegisteredOperations();
    for (const mlir::RegisteredOperationName& op: allOps) {
        llvm::ArrayRef<mlir::StringAttr> attributes = op.getAttributeNames();

        if (attributes.size() > mostAttributes) {
            mostAttributes = attributes.size();
            opWithMostAttributes = op.getStringRef().str();
        }

        file << op.getStringRef().str() << ", ";
        file << attributes.size() << " attributes: [";
        for (const mlir::StringAttr& attr: attributes) {
            file << attr.str() << ", ";
        }

        if (attributes.size() > 0) {
            file.seekp(-2, std::ios_base::end);
        }

        file << "]\n";
    }

    // Print the operation with the most attributes
    std::cout << "Operation with most attributes: " << opWithMostAttributes << " with " << mostAttributes << " attributes\n";
    
    return 0;
}
```

## mlir-opt flags
### Flags for tensor ops
```bash
--convert-elementwise-to-linalg
--convert-tensor-to-linalg
--convert-linalg-to-loops
--one-shot-bufferize=bufferize-function-boundaries=true
--convert-linalg-to-loops
--expand-strided-metadata
--lower-affine
--convert-index-to-llvm
--convert-math-to-llvm
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

## Temp
```llvm
(datatype MatOp
   (Mat String Shape)  ; (<name> <nrows> <ncols>)
   (MatMul MatOp MatOp Shape)
)

(let ma (Mat "a" (Shape2D 5 10)))
(let mb (Mat "b" (Shape2D 10 15)))
(let mc (Mat "c" (Shape2D 15 2)))

(let ab_c (MatMul (MatMul ma mb (Shape2D 5 15)) mc (Shape2D 5 2)))
(let a_bc (MatMul ma (MatMul mb mc (Shape2D 10 2)) (Shape2D 5 2)))

(function get-shape (MatOp) Shape)
(function calc-shape (MatOp) Shape)

(let sa (get-shape ma))
(let sb (get-shape mb))
(let sc (get-shape mc))

(let sab_c (get-shape ab_c))
(let sa_bc (get-shape a_bc))

(rewrite
 (get-shape (Mat ?n ?s))
 ?s
)

(rewrite
 (get-shape (MatMul ?a ?b ?s))
 ?s
)

(run 100)

(extract sa)
(extract sb)
(extract sc)

(extract sab_c)
(extract sa_bc)

(let csa (calc-shape ma))
(let csb (calc-shape mb))
(let csc (calc-shape mc))

(let csab_c (calc-shape ab_c))
(let csa_bc (calc-shape a_bc))

(rewrite
 (calc-shape (Mat ?n ?s))
 ?s
)

(rule
 (
  (= lhs (MatMul ?a ?b ?s))
 )
 (
  (union (calc-shape lhs) (Shape2D (get-nrows (calc-shape ?a)) (get-ncols (calc-shape ?b))))
 )
)

(run 100)

(extract csa)
(extract csb)
(extract csc)

(extract csab_c)
(extract csa_bc)

;(birewrite
;    (MatMul (MatMul ?a ?b (Shape2D i64 i64)) ?c)
;    (MatMul ?a (MatMul ?b ?c ) (Shape2D i64 i64))
;)
;
;(extract ma)
;(extract mb)
;(extract mc)
;
;(extract ab_c)
;(extract a_bc)
;
```
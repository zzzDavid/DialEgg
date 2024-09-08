func.func private @printI64(i64)
func.func private @printF64(f64)
func.func private @printComma()
func.func private @printNewline()

// C funcs
func.func private @clock() -> i64
func.func private @putchar(i32) -> i32
llvm.func @printf(!llvm.ptr, ...) -> i32

llvm.mlir.global constant @time("%d us -> %f s")
func.func @displayTime(%start: i64, %end: i64) {
    %diff = arith.subi %end, %start : i64
    %diff_f64 = arith.uitofp %diff : i64 to f64

    %million = arith.constant 1000000.0 : f64
    %diff_seconds = arith.divf %diff_f64, %million : f64

    // Format: "%f us -> %f s"
    %time_ptr = llvm.mlir.addressof @time : !llvm.ptr
    llvm.call @printf(%time_ptr, %diff, %diff_seconds) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32

    func.return
}

func.func @fillRandomF64Tensor2D(%tensor: tensor<1000000x4xf64>) -> tensor<1000000x4xf64> {
    // Create a 2D tensor with random values with the linalg.fill_rng_2d op

    %seed = arith.constant 0 : i32
    %min = arith.constant -10.0 : f64
    %max = arith.constant 10.0 : f64

    %tensor_filled = linalg.fill_rng_2d ins(%min, %max, %seed : f64, f64, i32) 
                                        outs(%tensor : tensor<1000000x4xf64>) -> tensor<1000000x4xf64>

    return %tensor_filled : tensor<1000000x4xf64>
}

func.func @printF64Tensor1D(%tensor : tensor<?xf64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index

    %lbracket = arith.constant 91 : i32
    func.call @putchar(%lbracket) : (i32) -> i32

    %size = tensor.dim %tensor, %c0 : tensor<?xf64>
    scf.for %i = %c0 to %size step %c1 {
        %val = tensor.extract %tensor[%i] : tensor<?xf64>
        func.call @printF64(%val) : (f64) -> ()

        %size_minus_one = index.sub %size, %c1
        %not_end = index.cmp ult(%i, %size_minus_one)
        scf.if %not_end { // print comma if not last element
            func.call @printComma() : () -> ()
        }
    }

    %rbracket = arith.constant 93 : i32
    func.call @putchar(%rbracket) : (i32) -> i32

    func.return
}

func.func @blackhole(%tensor: tensor<?xf64>) -> tensor<?xf64> {
    func.return %tensor : tensor<?xf64>
}


func.func @poly_eval_3(%a: f64, %b: f64, %c: f64, %d: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %c3 = arith.constant 3.0 : f64

    %x_2 = math.powf %x, %c2 fastmath<fast> : f64
    %x_3 = math.powf %x, %c3 fastmath<fast> : f64

    %t1 = arith.mulf %c, %x  fastmath<fast> : f64 // cx
    %t2 = arith.mulf %b, %x_2  fastmath<fast> : f64 // bx^2
    %t3 = arith.mulf %a, %x_3  fastmath<fast> : f64 // ax^3

    %t4 = arith.addf %t2, %t3 fastmath<fast> : f64 // ax^3 + bx^2
    %t5 = arith.addf %t1, %t4 fastmath<fast> : f64 // cx + ax^3 + bx^2
    %t6 = arith.addf %d, %t5 fastmath<fast> : f64 // d + cx + ax^3 + bx^2

    func.return %t6 : f64
}

func.func @poly_eval_2(%a: f64, %b: f64, %c: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %x_2 = math.powf %x, %c2 fastmath<fast> : f64

    %t1 = arith.mulf %b, %x  fastmath<fast> : f64 // bx
    %t2 = arith.mulf %a, %x_2  fastmath<fast> : f64 // ax^2

    %t3 = arith.addf %t1, %t2 fastmath<fast> : f64 // bx + ax^2
    %t4 = arith.addf %c, %t3 fastmath<fast> : f64 // c + bx + ax^2

    func.return %t4 : f64
}


func.func @main() -> i32 {
    // polynomial a + bx + cx^2 + dx^3
    %tensor = tensor.empty() : tensor<1000000x4xf64>
    %tensor_filled = func.call @fillRandomF64Tensor2D(%tensor) : (tensor<1000000x4xf64>) -> tensor<1000000x4xf64>

    %start = func.call @clock() : () -> i64
    
    %x = arith.constant 1.0 : f64
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c1000000 = arith.constant 1000000 : index

    %poly_eval_init = tensor.empty() : tensor<1000000xf64>
    %poly_eval = scf.for %i = %c0 to %c1000000 step %c1 iter_args(%current_poly_eval = %poly_eval_init) -> (tensor<1000000xf64>) {
        %a = tensor.extract %tensor_filled[%i, %c0] : tensor<1000000x4xf64>
        %b = tensor.extract %tensor_filled[%i, %c1] : tensor<1000000x4xf64>
        %c = tensor.extract %tensor_filled[%i, %c2] : tensor<1000000x4xf64>
        %d = tensor.extract %tensor_filled[%i, %c3] : tensor<1000000x4xf64>

        %num = func.call @poly_eval_3(%a, %b, %c, %d, %x) : (f64, f64, f64, f64, f64) -> f64
        %updated_poly_eval = tensor.insert %num into %current_poly_eval[%i] : tensor<1000000xf64>
        scf.yield %updated_poly_eval : tensor<1000000xf64>
    }

    %end = func.call @clock() : () -> i64

    %poly_eval_cast = tensor.cast %poly_eval : tensor<1000000xf64> to tensor<?xf64>
    // func.call @printF64Tensor1D(%poly_eval_cast) : (tensor<?xf64>) -> ()
    // func.call @printNewline() : () -> ()
    func.call @displayTime(%start, %end) : (i64, i64) -> ()
    func.call @blackhole(%poly_eval_cast) : (tensor<?xf64>) -> (tensor<?xf64>)

    %c0_i32 = arith.constant 0 : i32
    func.return %c0_i32 : i32
}


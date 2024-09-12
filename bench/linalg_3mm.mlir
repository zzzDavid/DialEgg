func.func private @printNewline()

// C funcs
func.func private @clock() -> i64
func.func private @putchar(i32) -> i32
llvm.func @printf(!llvm.ptr, ...) -> i32

llvm.mlir.global constant @time("%d us -> %f s")
func.func @displayTime(%start: i64, %end: i64) {
    %diff = arith.subi %end, %start : i64
    %diff_f64 = arith.uitofp %diff : i64 to f64

    %million = arith.constant 9000.0 : f64
    %diff_seconds = arith.divf %diff_f64, %million : f64

    // Format: "%f us -> %f s"
    %time_ptr = llvm.mlir.addressof @time : !llvm.ptr
    llvm.call @printf(%time_ptr, %diff, %diff_seconds) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32

    func.return
}

func.func @blackhole(%t : tensor<200x10xi64>) -> tensor<200x10xi64> {
    return %t : tensor<200x10xi64>
}

func.func @main() -> i32 {
    // Start measuring time
    %start = func.call @clock() : () -> i64

    %x = tensor.empty() : tensor<200x175xi64>
    %y = tensor.empty() : tensor<175x250xi64>
    %z = tensor.empty() : tensor<250x150xi64>
    %w = tensor.empty() : tensor<150x10xi64>

    %xy_init = tensor.empty() : tensor<200x250xi64>
    %xy = linalg.matmul ins(%x, %y : tensor<200x175xi64>, tensor<175x250xi64>) 
                        outs(%xy_init : tensor<200x250xi64>) -> tensor<200x250xi64>
    
    %xy_z_init = tensor.empty() : tensor<200x150xi64>
    %xy_z = linalg.matmul ins(%xy, %z : tensor<200x250xi64>, tensor<250x150xi64>) 
                          outs(%xy_z_init : tensor<200x150xi64>) -> tensor<200x150xi64>

    %xy_z__w_init = tensor.empty() : tensor<200x10xi64>
    %xy_z__w = linalg.matmul ins(%xy_z, %w : tensor<200x150xi64>, tensor<150x10xi64>) 
                             outs(%xy_z__w_init : tensor<200x10xi64>) -> tensor<200x10xi64>

    // End measuring time
    %end = func.call @clock() : () -> i64
    func.call @displayTime(%start, %end) : (i64, i64) -> ()
    
    func.call @blackhole(%xy_z__w) : (tensor<200x10xi64>) -> tensor<200x10xi64>
    %res = arith.constant 0 : i32
    func.return %res : i32
}
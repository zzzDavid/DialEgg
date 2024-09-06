func.func private @printNewline()

// C funcs
func.func private @clock() -> i64
func.func private @putchar(i32) -> i32
llvm.func @printf(!llvm.ptr, ...) -> i32

func.func @blackhole(%t : tensor<100x8xi64>) -> tensor<100x8xi64> {
    return %t : tensor<100x8xi64>
}

llvm.mlir.global constant @time("%d us -> %f s")
func.func @displayTime(%start: i64, %end: i64) {
    %diff = arith.subi %end, %start : i64
    %diff_f64 = arith.uitofp %diff : i64 to f64

    %million = arith.constant 10000.0 : f64
    %diff_seconds = arith.divf %diff_f64, %million : f64

    // Format: "%f us -> %f s"
    %time_ptr = llvm.mlir.addressof @time : !llvm.ptr
    llvm.call @printf(%time_ptr, %diff, %diff_seconds) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32

    func.return
}

func.func @main() -> i32 {
    // Start measuring time
    %start = func.call @clock() : () -> i64

    %x = tensor.empty() : tensor<100x10xi64>
    %y = tensor.empty() : tensor<10x150xi64>
    %z = tensor.empty() : tensor<150x8xi64>

    // xy_z cost ac(b+d) = 100*150*(10+8) = 2,700,000
    // x_yz cost bd(c+a) = 10*8*(150+100) = 2,000
    %xy_init = tensor.empty() : tensor<100x150xi64>
    %xy = linalg.matmul ins(%x, %y : tensor<100x10xi64>, tensor<10x150xi64>) 
                        outs(%xy_init : tensor<100x150xi64>) -> tensor<100x150xi64>
    
    %xy_z_init = tensor.empty() : tensor<100x8xi64>
    %xy_z = linalg.matmul ins(%xy, %z : tensor<100x150xi64>, tensor<150x8xi64>) 
                          outs(%xy_z_init : tensor<100x8xi64>) -> tensor<100x8xi64>
    
    // End measuring time
    %end = func.call @clock() : () -> i64
    func.call @displayTime(%start, %end) : (i64, i64) -> ()
    
    func.call @blackhole(%xy_z) : (tensor<100x8xi64>) -> tensor<100x8xi64>
    
    %res = arith.constant 0 : i32
    func.return %res : i32
}
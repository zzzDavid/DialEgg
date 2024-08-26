func.func private @printNewline()

// C funcs
func.func private @clock() -> i64
func.func private @putchar(i32) -> i32
llvm.func @printf(!llvm.ptr, ...) -> i32

llvm.mlir.global constant @time("%d us -> %f s")

func.func @blackhole(%t : tensor<10000x8xi64>) -> tensor<10000x8xi64> {
    return %t : tensor<10000x8xi64>
}

func.func @displayTime(%start: i64, %end: i64) {
    %diff = arith.subi %end, %start : i64
    %diff_f64 = arith.uitofp %diff : i64 to f64

    %million = arith.constant 1000000.0 : f64
    %diff_seconds = arith.divf %diff_f64, %million : f64

    // Format: "%f us -> %f s"
    %time_ptr = llvm.mlir.addressof @time : !llvm.ptr

    func.call @printNewline() : () -> ()
    func.call @printNewline() : () -> ()
    llvm.call @printf(%time_ptr, %diff, %diff_seconds) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32

    func.return
}

func.func @main() -> i32 {
    // Start measuring time
    %start = func.call @clock() : () -> i64

    %x = tensor.empty() : tensor<10000x10xi64>
    %y = tensor.empty() : tensor<10x15000xi64>
    %z = tensor.empty() : tensor<15000x8xi64>

    // xy_z cost ac(b+d) = 10000*15000*(10+8) = 2,700,000,000
    // x_yz cost bd(c+a) = 10*8*(15000+10000) = 2,000,000
    %xy_init = tensor.empty() : tensor<10000x15000xi64>
    %xy = linalg.matmul ins(%x, %y : tensor<10000x10xi64>, tensor<10x15000xi64>) 
                        outs(%xy_init : tensor<10000x15000xi64>) -> tensor<10000x15000xi64>
    
    %xy_z_init = tensor.empty() : tensor<10000x8xi64>
    %xy_z = linalg.matmul ins(%xy, %z : tensor<10000x15000xi64>, tensor<15000x8xi64>) 
                          outs(%xy_z_init : tensor<10000x8xi64>) -> tensor<10000x8xi64>
    
    // End measuring time
    %end = func.call @clock() : () -> i64
    func.call @displayTime(%start, %end) : (i64, i64) -> ()
    
    func.call @blackhole(%xy_z) : (tensor<10000x8xi64>) -> tensor<10000x8xi64>
    
    %res = arith.constant 0 : i32
    func.return %res : i32
}
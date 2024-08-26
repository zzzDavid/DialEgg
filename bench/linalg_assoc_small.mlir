func.func private @printNewline()

// C funcs
func.func private @clock() -> i64
llvm.func @printf(!llvm.ptr, ...) -> i32

llvm.mlir.global constant @time("%d us -> %f s")

func.func @fillRandomI64Tensor2D(%tensor: tensor<?x?xi64>) -> tensor<?x?xi64> {
    // Create a 2D tensor with random values with the linalg.fill_rng_2d op

    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index

    %cols = tensor.dim %tensor, %c1 : tensor<?x?xi64>
    %rows = tensor.dim %tensor, %c0 : tensor<?x?xi64>

    %seed = arith.constant 0 : i32
    %min = arith.constant 0.0 : f64
    %max = arith.constant 10.0 : f64
    %init = tensor.empty(%rows, %cols) : tensor<?x?xf64>

    %init_filled = linalg.fill_rng_2d ins(%min, %max, %seed : f64, f64, i32) 
                                      outs(%init : tensor<?x?xf64>) -> tensor<?x?xf64>

    // Floor each value and cast to i64 with generic op
    %init_floor = linalg.floor ins(%init_filled : tensor<?x?xf64>) outs(%init : tensor<?x?xf64>) -> tensor<?x?xf64>
    %tensor_filled = arith.fptosi %init_floor : tensor<?x?xf64> to tensor<?x?xi64>

    return %tensor_filled : tensor<?x?xi64>
}

func.func @xy_z(%x: tensor<100x10xi64>, %y: tensor<10x150xi64>, %z: tensor<150x8xi64>) -> tensor<100x8xi64> { // cost ac(b+d) = 100*150*(10+8) = 2,700,000,000
    %xy_init = tensor.empty() : tensor<100x150xi64>
    %xy = linalg.matmul ins(%x, %y : tensor<100x10xi64>, tensor<10x150xi64>) 
                        outs(%xy_init : tensor<100x150xi64>) -> tensor<100x150xi64>
    
    %xy_z_init = tensor.empty() : tensor<100x8xi64>
    %xy_z = linalg.matmul ins(%xy, %z : tensor<100x150xi64>, tensor<150x8xi64>) 
                          outs(%xy_z_init : tensor<100x8xi64>) -> tensor<100x8xi64>
    
    return %xy_z : tensor<100x8xi64>
}

func.func @x_yz(%x: tensor<100x10xi64>, %y: tensor<10x150xi64>, %z: tensor<150x8xi64>) -> tensor<100x8xi64> { // cost bd(c+a) = 10*8*(150+100) = 2,000,000
    %yz_init = tensor.empty() : tensor<10x8xi64>
    %yz = linalg.matmul ins(%y, %z : tensor<10x150xi64>, tensor<150x8xi64>) 
                        outs(%yz_init : tensor<10x8xi64>) -> tensor<10x8xi64>
    
    %x_yz_init = tensor.empty() : tensor<100x8xi64>
    %x_yz = linalg.matmul ins(%x, %yz : tensor<100x10xi64>, tensor<10x8xi64>) 
                          outs(%x_yz_init : tensor<100x8xi64>) -> tensor<100x8xi64>
    
    return %x_yz : tensor<100x8xi64>
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

func.func @main() -> f32 {
    // Start measuring time
    %start = func.call @clock() : () -> i64

    // x, y, and z
    %x_init = tensor.empty() : tensor<100x10xi64>
    %x_cast = tensor.cast %x_init : tensor<100x10xi64> to tensor<?x?xi64>
    %x_fill = func.call @fillRandomI64Tensor2D(%x_cast) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    // func.call @printI64Tensor2D(%x_fill) : (tensor<?x?xi64>) -> ()
    %x = tensor.cast %x_fill : tensor<?x?xi64> to tensor<100x10xi64>

    %y_init = tensor.empty() : tensor<10x150xi64>
    %y_cast = tensor.cast %y_init : tensor<10x150xi64> to tensor<?x?xi64>
    %y_fill = func.call @fillRandomI64Tensor2D(%y_cast) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    // func.call @printI64Tensor2D(%y_fill) : (tensor<?x?xi64>) -> ()
    %y = tensor.cast %y_fill : tensor<?x?xi64> to tensor<10x150xi64>

    %z_init = tensor.empty() : tensor<150x8xi64>
    %z_cast = tensor.cast %z_init : tensor<150x8xi64> to tensor<?x?xi64>
    %z_fill = func.call @fillRandomI64Tensor2D(%z_cast) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    // func.call @printI64Tensor2D(%z_fill) : (tensor<?x?xi64>) -> ()
    %z = tensor.cast %z_fill : tensor<?x?xi64> to tensor<150x8xi64>

    func.call @xy_z(%x, %y, %z) : (tensor<100x10xi64>, tensor<10x150xi64>, tensor<150x8xi64>) -> tensor<100x8xi64>
    // func.call @x_yz(%x, %y, %z) : (tensor<100x10xi64>, tensor<10x150xi64>, tensor<150x8xi64>) -> tensor<100x8xi64>

    // End measuring time
    %end = func.call @clock() : () -> i64
    func.call @displayTime(%start, %end) : (i64, i64) -> ()

    %res = arith.constant 0.0 : f32
    func.return %res : f32
}
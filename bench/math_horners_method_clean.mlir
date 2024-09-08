func.func @poly_eval_3(%a: f64, %b: f64, %c: f64, %d: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %c3 = arith.constant 3.0 : f64

    %x_2 = math.powf %x, %c2  : f64
    %x_3 = math.powf %x, %c3  : f64

    %t1 = arith.mulf %c, %x   : f64 // cx
    %t2 = arith.mulf %b, %x_2   : f64 // bx^2
    %t3 = arith.mulf %a, %x_3   : f64 // ax^3

    %t4 = arith.addf %t2, %t3  : f64 // ax^3 + bx^2
    %t5 = arith.addf %t1, %t4  : f64 // cx + ax^3 + bx^2
    %t6 = arith.addf %d, %t5  : f64 // d + cx + ax^3 + bx^2

    func.return %t6 : f64
}

func.func @main() -> i32 {
    %tensor = tensor.empty() : tensor<100000x4xf64>
    %tensor_filled = func.call @fillRandomF64Tensor2D(%tensor) : (tensor<100000x4xf64>) -> tensor<100000x4xf64>

    %x = arith.constant 1.0 : f64
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c100000 = arith.constant 100000 : index

    %poly_eval_init = tensor.empty() : tensor<100000xf64>
    %poly_eval = scf.for %i = %c0 to %c100000 step %c1 iter_args(%current_poly_eval = %poly_eval_init) -> (tensor<100000xf64>) {
        %a = tensor.extract %tensor_filled[%i, %c0] : tensor<100000x4xf64>
        %b = tensor.extract %tensor_filled[%i, %c1] : tensor<100000x4xf64>
        %c = tensor.extract %tensor_filled[%i, %c2] : tensor<100000x4xf64>
        %d = tensor.extract %tensor_filled[%i, %c3] : tensor<100000x4xf64>

        %num = func.call @poly_eval_3(%a, %b, %c, %d, %x) : (f64, f64, f64, f64, f64) -> f64
        %updated_poly_eval = tensor.insert %num into %current_poly_eval[%i] : tensor<100000xf64>
        scf.yield %updated_poly_eval : tensor<100000xf64>
    }

    %c0_i32 = arith.constant 0 : i32
    func.return %c0_i32 : i32
}


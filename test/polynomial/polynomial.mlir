func.func @poly_eval_2(%a: f64, %b: f64, %c: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %x_2 = math.powf %x, %c2 : f64

    %t1 = arith.mulf %b, %x  : f64 // bx
    %t2 = arith.mulf %a, %x_2  : f64 // ax^2

    %t3 = arith.addf %t1, %t2 : f64 // bx + ax^2
    %t4 = arith.addf %c, %t3 : f64 // c + bx + ax^2

    func.return %t4 : f64
}

func.func @poly_eval_3(%a: f64, %b: f64, %c: f64, %d: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %c3 = arith.constant 3.0 : f64

    %x_2 = math.powf %x, %c2 : f64 // x^2
    %x_3 = math.powf %x, %c3 : f64 // x^3

    %t1 = arith.mulf %c, %x  : f64 // cx
    %t2 = arith.mulf %b, %x_2  : f64 // bx^2
    %t3 = arith.mulf %a, %x_3  : f64 // ax^3

    %t4 = arith.addf %t2, %t3 : f64 // ax^3 + bx^2
    %t5 = arith.addf %t1, %t4 : f64 // cx + ax^3 + bx^2
    %t6 = arith.addf %d, %t5 : f64 // d + cx + ax^3 + bx^2

    func.return %t6 : f64
}

func.func @poly_eval_4(%a: f64, %b: f64, %c: f64, %d: f64, %e: f64, %x: f64) -> f64 {
    %c2 = arith.constant 2.0 : f64
    %c3 = arith.constant 3.0 : f64
    %c4 = arith.constant 4.0 : f64

    %x_2 = math.powf %x, %c2 : f64 // x^2
    %x_3 = math.powf %x, %c3 : f64 // x^3
    %x_4 = math.powf %x, %c4 : f64 // x^4

    %t1 = arith.mulf %d, %x  : f64 // dx
    %t2 = arith.mulf %c, %x_2  : f64 // cx^2
    %t3 = arith.mulf %b, %x_3  : f64 // bx^3
    %t4 = arith.mulf %a, %x_4  : f64 // ax^4

    %t5 = arith.addf %t3, %t4 : f64 // bx^3 + ax^4
    %t6 = arith.addf %t2, %t5 : f64 // cx^2 + bx^3 + ax^4
    %t7 = arith.addf %t1, %t6 : f64 // dx + cx^2 + bx^3 + ax^4
    %t8 = arith.addf %e, %t7 : f64 // e + dx + cx^2 + bx^3 + ax^4

    func.return %t8 : f64
}

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

func.func @printI64Tensor1D(%tensor : tensor<?xi64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index

    %lbracket = arith.constant 91 : i32
    func.call @putchar(%lbracket) : (i32) -> i32

    %size = tensor.dim %tensor, %c0 : tensor<?xi64>
    scf.for %i = %c0 to %size step %c1 {
        %val = tensor.extract %tensor[%i] : tensor<?xi64>
        func.call @printI64(%val) : (i64) -> ()

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

func.func @printI64Tensor2D(%tensor: tensor<?x?xi64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index

    %lbracket = arith.constant 91 : i32
    func.call @putchar(%lbracket) : (i32) -> i32

    %tab = arith.constant 9 : i32

    %size0 = tensor.dim %tensor, %c0 : tensor<?x?xi64>
    %size1 = tensor.dim %tensor, %c1 : tensor<?x?xi64>

    scf.for %i = %c0 to %size0 step %c1 {
        %tensor1D = tensor.extract_slice %tensor[%i, 0][1, %size1][1, 1] : tensor<?x?xi64> to tensor<?xi64>
        
        func.call @printNewline() : () -> ()
        func.call @putchar(%tab) : (i32) -> i32
        func.call @printI64Tensor1D(%tensor1D) : (tensor<?xi64>) -> ()

        %size0_minus_one = index.sub %size0, %c1
        %not_end = index.cmp ult(%i, %size0_minus_one)
        scf.if %not_end { // print comma if not last element
            func.call @printComma() : () -> ()
        }
    }

    %size0_gt_0 = index.cmp sgt(%size0, %c0)
    scf.if %size0_gt_0 { // new line if size0 > 0
        func.call @printNewline() : () -> ()
    }

    %rbracket = arith.constant 93 : i32
    func.call @putchar(%rbracket) : (i32) -> i32

    func.return
}

func.func @rgb_to_grayscale(%r: i64, %g: i64, %b: i64) -> i64 {
	%c256 = arith.constant 256 : i64
	
    // nums from https://www.baeldung.com/cs/convert-rgb-to-grayscale
	%w_r = arith.constant 77 : i64
	%w_g = arith.constant 150 : i64
	%w_b = arith.constant 29 : i64
	
	%r_s = arith.muli %r, %w_r : i64
	%g_s = arith.muli %g, %w_g : i64
	%b_s = arith.muli %b, %w_b : i64

	%r_f = arith.divsi %r_s, %c256 : i64
	%g_f = arith.divsi %g_s, %c256 : i64
	%b_f = arith.divsi %b_s, %c256 : i64

    // change above divisions to bitshifts
    // %c8 = arith.constant 8 : i64
    // %r_f = arith.shrsi %r_s, %c8 : i64
    // %g_f = arith.shrsi %g_s, %c8 : i64
    // %b_f = arith.shrsi %b_s, %c8 : i64
	
	%sum = arith.addi %r_f, %g_f : i64
	%gray = arith.addi %sum, %b_f : i64

	func.return %gray : i64
}

func.func @blackhole1(%t : tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64> {
    return %t : tensor<3840x2160x3xi64>
}

func.func @blackhole2(%t : tensor<3840x2160xi64>) -> tensor<3840x2160xi64> {
    return %t : tensor<3840x2160xi64>
}

func.func @main() -> i64 { // convert 4K RGB image to grayscale
    %val = arith.constant 100 : i64
    %image = tensor.empty() : tensor<3840x2160x3xi64>  // 3840x2160 image with 3 channels (r, g, b)
    %image_filled_0  = linalg.fill ins(%val : i64) outs(%image : tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64>
    %image_filled = func.call @blackhole1(%image_filled_0) : (tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64> // avoid opt related to all the data being 100s

    %start = func.call @clock() : () -> i64  // Start measuring time

    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index

    %rows = arith.constant 3840 : index
    %cols = arith.constant 2160 : index
    %image_gray_init = tensor.empty() : tensor<3840x2160xi64>

    %image_gray = scf.for %i = %c0 to %rows step %c1 iter_args(%current_image = %image_gray_init) -> (tensor<3840x2160xi64>) {
        %row_result = scf.for %j = %c0 to %cols step %c1 iter_args(%current_row = %current_image) -> (tensor<3840x2160xi64>) {
            %r = tensor.extract %image_filled[%i, %j, %c0] : tensor<3840x2160x3xi64>
            %g = tensor.extract %image_filled[%i, %j, %c1] : tensor<3840x2160x3xi64>
            %b = tensor.extract %image_filled[%i, %j, %c2] : tensor<3840x2160x3xi64>

            %gray = func.call @rgb_to_grayscale(%r, %g, %b) : (i64, i64, i64) -> i64

            %updated_row = tensor.insert %gray into %current_row[%i, %j] : tensor<3840x2160xi64>
            scf.yield %updated_row : tensor<3840x2160xi64>
        }
        scf.yield %row_result : tensor<3840x2160xi64>
    }

    %end = func.call @clock() : () -> i64  // End measuring time

    // %image_gray_cast = tensor.cast %image_gray : tensor<3840x2160xi64> to tensor<?x?xi64>
    // func.call @printI64Tensor2D(%image_gray_cast) : (tensor<?x?xi64>) -> ()

    func.call @displayTime(%start, %end) : (i64, i64) -> ()

    func.call @blackhole2(%image_gray) : (tensor<3840x2160xi64>) -> (tensor<3840x2160xi64>)

    %c0_i64 = arith.constant 0 : i64
    func.return %c0_i64 : i64
}
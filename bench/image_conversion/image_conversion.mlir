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
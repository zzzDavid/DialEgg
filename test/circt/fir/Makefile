# Makefile for FIR roundtrip pipeline
# Uses roundtrip.sh to process Verilog -> MLIR -> optimization -> Verilog

.PHONY: all clean roundtrip

# Default target
all: roundtrip

# Run the complete roundtrip pipeline
roundtrip:
	@echo "Running FIR roundtrip pipeline..."
	./roundtrip.sh

# Clean all intermediate and result files
clean:
	@echo "Cleaning all intermediate and result files..."
	rm -f fir.mlir
	rm -f fir_optimized.mlir
	rm -f fir_optimized.v
	rm -f fir_output.sv
	rm -f *.log
	@echo "Clean complete!"

# Clean everything including source files (use with caution)
distclean: clean
	@echo "Removing all generated and source files..."
	rm -f fir.v
	rm -f fir.egg
	rm -f fir.ops.egg
	rm -f filelist.f
	@echo "Distclean complete!" 
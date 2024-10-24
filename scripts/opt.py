import os
import subprocess
import sys

# generate optimized mlir files
def opt_file(file_path):
    file_path_no_ext = file_path.removesuffix(".mlir")

    # Create .canon.mlir file
    subprocess.run(["mlir-opt", "--mlir-disable-threading", "--canonicalize", file_path, "-o", f"{file_path_no_ext}.canon.mlir"])
    # Create .eqsat.mlir file
    subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--eq-sat", file_path, "-o", f"{file_path_no_ext}.eqsat.mlir"])
    # Create .canon+eqsat.mlir file
    subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--canonicalize", "--eq-sat", file_path, "-o", f"{file_path_no_ext}.canon+eqsat.mlir"])
    # Create .eqsat+canon.mlir file
    subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--eq-sat", "--canonicalize", file_path, "-o", f"{file_path_no_ext}.eqsat+canon.mlir"])

    if file_path.startswith("bench/linalg"):
        # create extra .cpp.mlir files
        subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--matmul-associate", file_path, "-o", f"{file_path_no_ext}.cpp.mlir"])

def main():
    opt_file("bench/arith_rgb_to_gray.mlir")
    opt_file("bench/linalg_assoc.mlir")
    opt_file("bench/linalg_3mm.mlir")
    opt_file("bench/math_inv_sqrt.mlir")
    opt_file("bench/math_horners_method.mlir")

if __name__ == "__main__":
    main()
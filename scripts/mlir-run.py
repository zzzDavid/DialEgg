import os
import subprocess
import sys

# Script to lower and run MLIR code

# Usualy the process is
# mlir-opt <FLAGS> <MLIR_FILE_PATH/MLIR_FILE_NAME.mlir> -o <MLIR_FILE_PATH/MLIR_FILE_NAME.ll.mlir>
# mlir-translate --mlir-to-llvmir <MLIR_FILE_PATH/MLIR_FILE_NAME.ll.mlir> -o <MLIR_FILE_PATH/MLIR_FILE_NAME.ll>
# lli --dlopen=/Users/aziz/dev/lib/llvm/build/lib/libmlir_c_runner_utils.dylib <MLIR_FILE_PATH/MLIR_FILE_NAME.ll>

def run_mlir(mlir_file):
    mlir_filepath = os.path.dirname(mlir_file)
    mlir_filename = os.path.basename(mlir_file).replace(".mlir", "") # filename wihtout path and extension
    run_dir = os.path.join(mlir_filepath, "run")

    flags = (
        "--convert-elementwise-to-linalg "
        "--convert-tensor-to-linalg "
        "--convert-linalg-to-loops "
        "--one-shot-bufferize=bufferize-function-boundaries=true "
        "--convert-linalg-to-loops "
        "--expand-strided-metadata "
        "--lower-affine "
        "--convert-index-to-llvm "
        "--convert-math-to-llvm "
        "--convert-scf-to-cf "
        "--convert-cf-to-llvm "
        "--convert-arith-to-llvm "
        "--convert-func-to-llvm "
        "--finalizing-bufferize "
        "--finalize-memref-to-llvm "
        "--reconcile-unrealized-casts "
    )

    # Lower the MLIR code to LLVM IR
    mlir_ll_file = os.path.join(run_dir, f"{mlir_filename}.ll.mlir")
    print(f"Creating {mlir_ll_file}")
    # subprocess.run(["mlir-opt", *flags, mlir_file, "-o", mlir_ll_file])
    subprocess.run(f"mlir-opt {flags} {mlir_file} -o {mlir_ll_file}", shell=True, check=True)  # mlir-opt $FLAGS $MLIR_FILE -o $mlir_ll_file

    # Translate the MLIR code to LLVM IR
    ll_file = os.path.join(run_dir, f"{mlir_filename}.ll")
    print(f"Creating {ll_file}")
    subprocess.run(["mlir-translate", "--mlir-to-llvmir", mlir_ll_file, "-o", ll_file]) # mlir-translate --mlir-to-llvmir $mlir_ll_file -o $ll_file

    # Create executable from the LLVM IR code
    o_file = os.path.join(run_dir, f"{mlir_filename}.o")
    print(f"Creating {o_file}")
    subprocess.run(["llc", "-filetype=obj", "-O3", ll_file, "-o", o_file]) # llc -filetype=obj $ll_file -o $o_file

    exec_file = os.path.join(run_dir, mlir_filename)
    print(f"Creating {exec_file}")

    lib_path = "/Users/aziz/dev/lib/llvm/build/lib"
    lib = "mlir_c_runner_utils"
    subprocess.run(["clang", o_file, "-o", exec_file, f"-L{lib_path}", f"-l{lib}", f"-Wl,-rpath,{lib_path}"]) # clang $o_file -o $exe_file -L/Users/aziz/dev/lib/llvm/build/lib -lmlir_c_runner_utils -Wl,-rpath,/Users/aziz/dev/lib/llvm/build/lib

    # Run the executable
    print("Running the executable")
    result = subprocess.run(exec_file, shell=True, text=True, capture_output=True) # exe_file
    print(result.stdout)
    # if result.stderr:
    #     print(result.stderr, file=sys.stderr)
    
    sys.exit(result.returncode) # Make last exit code the exit code of this script

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <mlir_filepath/mlir_filename.mlir>")
        sys.exit(1)
    
    mlir_file = sys.argv[1]
    run_mlir(mlir_file)
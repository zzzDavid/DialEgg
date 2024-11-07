import os
import subprocess
import sys
import re

def count(file_path, interest_function):
    """Count the number of lines in the function of interest in the given file."""
    res = subprocess.run(["mlir-opt", file_path], capture_output=True, text=True)

    # find "func.func @interest_function(" and count the number of lines until the next "}" with the same indentation
    lines = res.stdout.split("\n")
    for i, line in enumerate(lines):
        if f"func.func @{interest_function}(" in line:
            indent = line.index("func")
            start = i

            for j, line in enumerate(lines[i:]):
                if line.startswith(" " * indent + "}"):
                    end = i + j
                    break
    
    print(f"Number of lines in {interest_function} in {file_path}: {end - start + 1}")


def main():
    count("bench/arith_rgb_to_gray.mlir", "rgb_to_grayscale")
    count("bench/linalg_assoc.mlir", "main")
    count("bench/linalg_3mm.mlir", "main")
    count("bench/math_inv_sqrt.mlir", "normalize_vector")
    count("bench/math_horners_method.mlir", "poly_eval_3")

if __name__ == "__main__":
    main()
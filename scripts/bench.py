import os
import re
import mlir_run
import pandas as pd
import statistics

def same_name_files(name, directory):
    return [f for f in os.listdir(directory) if f.startswith(name) and f.endswith(".mlir")]

def benchmark_file(filename, directory):
    all_mlir_files = same_name_files(filename, directory)
    all_opt_levels = ["-O0", "-O1", "-O2", "-O3"]
    n_runs = 51  # number of runs, first run is warmup
    regex_time = re.compile(r"(\d+) us -> (\d+\.\d+) s")  # format "53926 us -> 0.053926 s"

    # Persist data, cols are: the name of the opt type, and each opt level
    data = {
        "name": [],
        "opt": [],
    }
    for opt_level in all_opt_levels:
        data[opt_level] = []

    print(f"--------------------------- Running {filename} ---------------------------")

    for mlir_file in all_mlir_files:
        ext = mlir_file.split(".")[-2]
        if ext == filename:
            ext = "noopt"
        
        data["opt"].append(ext)
        data["name"].append(filename)
        for opt_level in all_opt_levels:

            times = []
            for i in range(n_runs):
                time = mlir_run.run_mlir_file(f"{directory}/{mlir_file}", opt=opt_level, verbose=False)
                match = regex_time.search(time)
                if match:
                    times.append(float(match.group(1)))

            times = times[1:]
            avg_time = statistics.mean(times)
            median_time = statistics.median(times)

            data[opt_level].append(median_time)
            print(f"[{ext}:{opt_level}] times:{times} us, avg:{avg_time} us, median:{median_time} us")

        print()

    print(data)
    df = pd.DataFrame(data)
    df.to_csv(f"bench/{filename}.csv", index=False)

if __name__ == "__main__":
    benchmark_file("arith_rgb_to_gray", "bench")  # bench/arith_rgb_to_gray.mlir
    benchmark_file("linalg_assoc", "bench")  # bench/linalg_assoc.mlir
    benchmark_file("math_inv_sqrt", "bench")  # bench/math_inv_sqrt.mlir
    benchmark_file("math_horners_method", "bench")  # bench/math_horners_method.mlir
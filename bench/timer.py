import subprocess
import re
import statistics

def eq_sat_time(file_path, interest_function, data, nruns=10):
    if file_path not in data:
        data[file_path] = {}

    times = {}
    saturation_times = []
    for i in range(nruns):
        res = subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--eq-sat", file_path], capture_output=True, text=True)

        # find the text "Done running on function: " + interest_function, then print it and the 6 lines after it
        lines = res.stdout.split("\n")
        for i, line in enumerate(lines):
            if line == f"Done running on function: {interest_function}":
                for j, line in enumerate(lines[i:i+7]):
                    for keyword in ['mlirToEgglogTime', 'egglogExecTime', 'egglogToMlirTime']:
                        if keyword in line:
                            # line is like : "mlirToEgglogCpuTime = 2.467200e-02s" so get the number
                            total_time = float(line.split("=")[1][:-1].strip())
                            
                            if keyword not in times:
                                times[keyword] = []
                            
                            times[keyword].append(total_time)
                            break
        
        # find "Running on function: " + interest_function, then after that, find the line "Ruleset rules: search ..."
        for i, line in enumerate(lines):
            if line == f"Running on function: {interest_function}":
                for j, line in enumerate(lines[i:]):
                    if "Ruleset rules: search" in line:
                        # this line is like: "Ruleset rules: search 0.002s, apply 0.001s, rebuild 0.001s" so sum the numbers to get the total time
                        # print(line)
                        total_time = sum([float(x) for x in re.findall(r"\d+\.\d+", line)])
                        saturation_times.append(total_time)
                        break
    
    data[file_path]["egglogSaturateTime"] = statistics.median(saturation_times)
    for key in times:
        data[file_path][key] = statistics.median(times[key])


def canon_time(file_path, data):
    if file_path not in data:
        data[file_path] = {}
    nruns = 10

    times = []
    for i in range(nruns):
        res = subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--canonicalize", "-mlir-timing", file_path], capture_output=True, text=True)

        lines = res.stderr.split("\n")
        for i, line in enumerate(lines):
            if "Canonicalizer" in line:
                # line is like "0.0233 ( 68.6%)    Canonicalizer" so get the first number
                total_time = float(re.findall(r"\d+\.\d+", line)[0])
                times.append(total_time)
    
    data[file_path]["Canon"] = statistics.median(times)
        

def cpp_time(file_path, data):
    if file_path not in data:
        data[file_path] = {}
    nruns = 10

    times = []
    for i in range(nruns):
        res = subprocess.run(["./build/egg-opt", "--mlir-disable-threading", "--matmul-associate", "-mlir-timing", file_path], capture_output=True, text=True)

        lines = res.stderr.split("\n")
        for i, line in enumerate(lines):
            if "MatrixMultiplyAssociatePass" in line:
                # line is like "0.0233 ( 68.6%)    MatrixMultiplyAssociatePass" so get the first number
                total_time = float(re.findall(r"\d+\.\d+", line)[0])
                times.append(total_time)
    
    data[file_path]["C++ impl"] = statistics.median(times)


def main():
    data = {}

    eq_sat_time("bench/image_conversion/image_conversion.mlir", "rgb_to_grayscale", data)
    eq_sat_time("bench/vector_norm/vector_norm.mlir", "normalize_vector", data)
    eq_sat_time("bench/polynomial/polynomial.mlir", "poly_eval_3", data)
    eq_sat_time("bench/2mm/2mm.mlir", "_2mm", data)
    eq_sat_time("bench/3mm/3mm.mlir", "_3mm", data)

    cpp_time("bench/2mm/2mm.mlir", data)
    cpp_time("bench/3mm/3mm.mlir", data)

    canon_time("bench/image_conversion/image_conversion.mlir", data)
    canon_time("bench/vector_norm/vector_norm.mlir", data)
    canon_time("bench/polynomial/polynomial.mlir", data)
    canon_time("bench/2mm/2mm.mlir", data)
    canon_time("bench/3mm/3mm.mlir", data)

    # for n in [2, 3, 4, 5, 10, 20, 40]:
    #     file  = f"mm/linalg_{n}mm.mlir"
    #     eq_sat_time(file, "main", data)

    print(data)


if __name__ == "__main__":
    main()
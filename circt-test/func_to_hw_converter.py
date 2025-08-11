#!/usr/bin/env python3
"""
Automatic Func Dialect to HW Dialect Converter for CIRCT Export
Converts func.func/func.return to hw.module/hw.output
"""

import re
import sys

def convert_func_to_hw(mlir_content):
    """Convert Func dialect MLIR to HW dialect MLIR"""
    
    # Extract function name and signature from func.func
    func_pattern = r'func\.func\s+@(\w+)\(([^)]+)\)\s*->\s*([^{]+)\s*\{'
    match = re.search(func_pattern, mlir_content)
    
    if not match:
        raise ValueError("No func.func found in input")
    
    func_name = match.group(1)
    args = match.group(2)
    return_type = match.group(3).strip()
    
    # Parse function arguments to hw.module ports
    inputs = []
    
    # Split arguments by comma and parse
    if args.strip():
        arg_parts = [p.strip() for p in args.split(',')]
        for part in arg_parts:
            # Extract: "%delay0: i16" -> "in %delay0 : i16"
            var_type = part.replace(': ', ' : ')
            inputs.append(f"in {var_type}")
    
    # Create output port
    outputs = [f"out result : {return_type}"]
    
    # Combine all ports
    all_ports = inputs + outputs
    ports_str = ', '.join(all_ports)
    
    # Create hw.module header
    hw_header = f"  hw.module @{func_name}({ports_str}) {{"
    
    # Find func.return and extract return value
    return_pattern = r'func\.return\s+([^:]+)\s*:'
    return_match = re.search(return_pattern, mlir_content)
    
    if return_match:
        return_value = return_match.group(1).strip()
        hw_output = f"    hw.output {return_value} : {return_type}"
    else:
        hw_output = f"    hw.output %result : {return_type}"
    
    # Perform replacements
    result = mlir_content
    
    # Replace the func.func line
    result = re.sub(func_pattern, hw_header, result)
    
    # Replace func.return with hw.output
    result = re.sub(r'func\.return[^}]+', hw_output, result)
    
    # Replace bare 'return' with hw.output (in case DialEgg simplified it)
    result = re.sub(r'\s+return\s+([^:]+)\s*:\s*([^}]+)', f'    hw.output \\1 : \\2', result)
    
    return result

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 func_to_hw_converter.py <input.mlir> <output.mlir>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    try:
        with open(input_file, 'r') as f:
            content = f.read()
        
        converted = convert_func_to_hw(content)
        
        with open(output_file, 'w') as f:
            f.write(converted)
        
        print(f"✅ Converted {input_file} → {output_file}")
        print("   func.func → hw.module")  
        print("   func.return → hw.output")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 
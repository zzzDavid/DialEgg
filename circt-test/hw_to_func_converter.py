#!/usr/bin/env python3
"""
Automatic HW Dialect to Func Dialect Converter for DialEgg
Converts hw.module/hw.output to func.func/func.return
"""

import re
import sys

def convert_hw_to_func(mlir_content):
    """Convert HW dialect MLIR to Func dialect MLIR"""
    
    # Extract module name and ports from hw.module
    module_pattern = r'hw\.module\s+@(\w+)\(([^)]+)\)\s*\{'
    match = re.search(module_pattern, mlir_content)
    
    if not match:
        raise ValueError("No hw.module found in input")
    
    module_name = match.group(1)
    ports = match.group(2)
    
    # Parse input and output ports
    inputs = []
    outputs = []
    
    # Split ports by comma and parse
    port_parts = [p.strip() for p in ports.split(',')]
    for part in port_parts:
        if part.startswith('in '):
            # Extract: "in %delay0 : i16" -> "%delay0: i16"
            var_type = part[3:].strip()  # Remove "in "
            inputs.append(var_type.replace(' : ', ': '))
        elif part.startswith('out '):
            # Extract: "out result : i16" -> "i16"
            output_type = part[4:].strip().split(' : ')[1]
            outputs.append(output_type)
    
    # Create func signature
    input_args = ', '.join(inputs)
    output_type = outputs[0] if outputs else 'i16'  # Assume single output
    
    # Replace hw.module with func.func
    func_header = f"  func.func @{module_name}({input_args}) -> {output_type} {{"
    
    # Replace hw.output with func.return
    # Find the hw.output line and extract the return value
    output_pattern = r'hw\.output\s+([^:]+)\s*:'
    output_match = re.search(output_pattern, mlir_content)
    
    if output_match:
        return_value = output_match.group(1).strip()
        func_return = f"    func.return {return_value} : {output_type}"
    else:
        func_return = f"    func.return %result : {output_type}"
    
    # Perform replacements
    result = mlir_content
    
    # Replace the hw.module line
    result = re.sub(module_pattern, func_header, result)
    
    # Replace hw.output with func.return
    result = re.sub(r'hw\.output[^}]+', func_return, result)
    
    # Clean up the closing brace
    result = result.replace('  }\n}', '  }\n}')
    
    return result

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 hw_to_func_converter.py <input.mlir> <output.mlir>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    try:
        with open(input_file, 'r') as f:
            content = f.read()
        
        converted = convert_hw_to_func(content)
        
        with open(output_file, 'w') as f:
            f.write(converted)
        
        print(f"✅ Converted {input_file} → {output_file}")
        print("   hw.module → func.func")  
        print("   hw.output → func.return")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 
#!/usr/bin/env python3
"""
Verify that the vec_of_rule test worked by checking the e-graph JSON output.
"""
import json
import sys

def main():
    print("=" * 60)
    print("Verifying vec_of_rule test results")
    print("=" * 60)
    
    # Load the updated JSON with the e-graph
    with open("vec_of_rule.updated.json", "r") as f:
        data = json.load(f)
    
    # Find the comb_concat operations
    concat_ops = {}
    for node_id, node in data["nodes"].items():
        if node["op"] == "comb_concat":
            concat_ops[node_id] = node
    
    print(f"\nFound {len(concat_ops)} comb_concat operations")
    
    # Check for swapped operands
    # We expect to see OpVec-4 which has the swapped order
    swapped_opvec = None
    original_opvec = None
    
    for node_id, node in data["nodes"].items():
        if node["op"] == "OpVec":
            children = node.get("children", [])
            if len(children) == 2:
                # Check if this is the original order (Value 1, Value 2)
                # or swapped order (Value 2, Value 1)
                child_vals = []
                for child_id in children:
                    if child_id in data["nodes"]:
                        child_node = data["nodes"][child_id]
                        if child_node["op"] == "Value":
                            # Get the value ID (first child of Value)
                            val_id = data["nodes"][child_node["children"][0]]["op"]
                            child_vals.append(int(val_id))
                
                if len(child_vals) == 2:
                    if child_vals == [1, 2]:
                        original_opvec = node_id
                        print(f"  ✓ Found original OpVec: {node_id} = [Value1, Value2]")
                    elif child_vals == [2, 1]:
                        swapped_opvec = node_id
                        print(f"  ✓ Found swapped OpVec: {node_id} = [Value2, Value1]")
    
    print("\n" + "=" * 60)
    if swapped_opvec:
        print("✅ TEST PASSED!")
        print("   The rule successfully swapped the concat operands")
        print(f"   Original: OpVec with [Value1, Value2]")
        print(f"   Optimized: OpVec with [Value2, Value1]")
    else:
        print("❌ TEST FAILED!")
        print("   No swapped OpVec found in the e-graph")
        return 1
    
    # Additional info
    print("\n" + "=" * 60)
    print("E-graph Statistics:")
    print(f"  Total nodes: {len(data['nodes'])}")
    print(f"  Root eclasses: {data.get('root_eclasses', [])}")
    print("=" * 60)
    
    return 0

if __name__ == "__main__":
    sys.exit(main())

import json
import argparse


def main():
    parser = argparse.ArgumentParser(description="Find root eclasses and update JSON for a given design name.")
    parser.add_argument("design_name", help="Design name (prefix for .ops.json and .updated.json files)")
    args = parser.parse_args()

    design_name = args.design_name

    with open(f"{design_name}.ops.json", "r") as f:
        data = json.load(f)

    root_eclasses = set()

    for key, node in data["nodes"].items():
        if node["op"] == "RootNode":
            root_eclasses.add(node["eclass"])

    data["root_eclasses"] = sorted(list(root_eclasses))

    with open(f"{design_name}.updated.json", "w") as f:
        json.dump(data, f, indent=2)

    print(root_eclasses)


if __name__ == "__main__":
    main()
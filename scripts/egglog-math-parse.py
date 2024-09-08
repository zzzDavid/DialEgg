# parse "(Add (Num "1") (Var "x"))" into 1 + x

def split_egglog_expr(line: str) -> list[str]:
    if not line.startswith('(') or not line.endswith(')'):
        raise ValueError(f"Invalid expression: {line}")
    
    result = []
    current = ""

    openParentheses = 0
    inQuotes = False

    for i in range(1, len(line) - 1):
        char = line[i]

        if char == '(':
            openParentheses += 1
        elif char == ')':
            openParentheses -= 1
        
        if char == '"' and line[i - 1] != '\\':
            inQuotes = not inQuotes
        
        if char == ' ' and openParentheses == 0 and not inQuotes and current.strip() != "":
            result.append(current)
            current = ""
        else:
            current += char

    if current.strip() != "":
        result.append(current)

    return result

def parse_egglog_expr(line):
    # remove everything after the first semicolon
    line = line.split(';')[0]
    tokens = split_egglog_expr(line)

    if len(tokens) == 0:
        raise ValueError("No tokens found")
    
    func = tokens[0]

    if func == "Add":
        return f"({parse_egglog_expr(tokens[1])} + {parse_egglog_expr(tokens[2])})"
    elif func == "Mul":
        return f"{parse_egglog_expr(tokens[1])}{parse_egglog_expr(tokens[2])}"
    elif func == "Sub":
        return f"({parse_egglog_expr(tokens[1])} - {parse_egglog_expr(tokens[2])})"
    elif func == "Div":
        return f"({parse_egglog_expr(tokens[1])} / {parse_egglog_expr(tokens[2])})"
    elif func == "Pow":
        return f"({parse_egglog_expr(tokens[1])} ** {tokens[2]})"
    elif func == "Var":
        return tokens[1].replace('"', '')
    elif func == "Num":
        return tokens[1]
    else:
        raise ValueError(f"Unknown function: {func}")

    
if __name__ == "__main__":
    line = input("Egglog expression: ")
    print(parse_egglog_expr(line))

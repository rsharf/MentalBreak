
keywords = ["Shorn", "Aegis", "Binding", "Fistwraps", "Razor", "Vedium", "Flux", "Search"]

try:
    with open('all_items_utf8.txt', 'r', encoding='utf-8') as f:
        for line in f:
            for kw in keywords:
                if kw.lower() in line.lower():
                    print(line.strip())
except Exception as e:
    print(f"Error: {e}")

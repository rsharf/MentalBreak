
keywords = [
    "Shorn", "Aegis", "Focus", "Razor", "Fistwraps", "Vedium", "Spite", "Axe", "Spiritstaff"
]

results = []
try:
    with open('all_items_utf8.txt', 'r', encoding='utf-8') as f:
        for line in f:
            for kw in keywords:
                if kw.lower() in line.lower():
                    results.append(line.strip())
                    break
except Exception as e:
    print(f"Error: {e}")

with open('search_results_v2.txt', 'w', encoding='utf-8') as f:
    for res in results:
        f.write(res + "\n")

print(f"Found {len(results)} matches.")

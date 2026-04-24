
keywords = {
    "Beastlord 2.0": ["Shorn", "Daws"],
    "Cleric 2.0": ["Aegis", "Divine", "Light"],
    "Magician 2.0": ["Focus", "Elemental", "Binding"],
    "Monk 2.0": ["Fistwraps", "Obscurity"],
    "Rogue 2.0": ["Razor", "Shadows"],
    "Warrior 2.0": ["Krelwin", "Vedium", "Sword"],
    "Berserker 1.0": ["Kerasian", "Spite"],
    "Blade of Vesagrop": ["Vesagrop", "Vesagran"]
}

results = {}
try:
    with open('all_items_utf8.txt', 'r', encoding='utf-8') as f:
        items = f.readlines()
        
    for label, kws in keywords.items():
        matches = []
        for line in items:
            line_low = line.lower()
            if all(kw.lower() in line_low for kw in kws):
                matches.append(line.strip())
        results[label] = matches
except Exception as e:
    print(f"Error: {e}")

with open('fuzzy_epic_results.json', 'w', encoding='utf-8') as f:
    import json
    json.dump(results, f, indent=4)

print("Fuzzy search complete.")
for label, matches in results.items():
    print(f"{label}: {len(matches)} matches")

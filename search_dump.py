
import re

keywords = [
    "Shorn", "Brambles", "Vesagran", "Vesagrop", "Divine Light", 
    "Phenomenal", "Obscurity", "Morning Star", "Heyokah", 
    "Vedium", "Prismatic Power", "Elemental Binding", 
    "Savage Spirit", "Flux", "Nem Ankh", "Nature Walkers", 
    "Celestial Fists", "Shadowed Soul", "Jagged Blade of War", 
    "Ragebringer", "Innoruuk", "Spear of Fate", "Swiftwind", 
    "Earthcaller", "Fiery Defender", "Vesagran", "Axe of Spite", 
    "Blood Axe", "Spiritstaff", "Krelwin", "Vengeful Taelosian"
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

with open('search_results_final.txt', 'w', encoding='utf-8') as f:
    for res in results:
        f.write(res + "\n")

print(f"Found {len(results)} matches.")

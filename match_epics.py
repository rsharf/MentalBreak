
import json

requested_items = [
    "Singing Short Sword", "Blade of Vesagrop",
    "Claw of the Savage Spirit", "Spirit-Shorn Daws",
    "Kerasian Axe of Spite", "Vengeful Taelosian Blood Axe",
    "Water Sprinkler of Nem Ankh", "Aegis of Divine Light",
    "Nature Walker's Scimitar", "Staff of Everliving Brambles",
    "Staff of the Serpent", "Staff of Phenomenal Power",
    "Scythe of the Shadowed Soul", "Focus of Elemental Binding",
    "Celestial Fists", "Transcended Fistwraps of Obscurity",
    "Deathwhisper",
    "Fiery Defender", "Redemption",
    "Swiftwind", "Earthcaller", "Aurora, the Morning Star",
    "Ragebringer", "Razor of Shadows",
    "Innoruuk's Curse", "Innoruuk's Dark Blessing",
    "Spear of Fate", "Blessed Spiritstaff of the Heyokah",
    "Jagged Blade of War", "Krelwin's Vedium Sword",
    "Staff of the Flux", "Staff of Prismatic Power",
    "Staff of the Four"
]

mapping = {}
try:
    with open('all_items_utf8.txt', 'r', encoding='utf-8') as f:
        items = f.readlines()
        
    for req in requested_items:
        clean_req = req.replace("'", "").replace("`", "").lower()
        matches = []
        for line in items:
            parts = line.strip().split('\t')
            if len(parts) >= 2:
                id, name = parts[0], parts[1]
                clean_name = name.replace("'", "").replace("`", "").lower()
                
                # Check for exact match or substantial substring
                if clean_req in clean_name or clean_name in clean_req:
                    matches.append({"id": id, "name": name})
        
        mapping[req] = matches
except Exception as e:
    print(f"Error: {e}")

with open('epic_final_matches.json', 'w', encoding='utf-8') as f:
    json.dump(mapping, f, indent=4)

print("Mapping complete.")

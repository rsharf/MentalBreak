
import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

epic_list = [
    "Singing Short Sword", "Blade of Vesagrop",
    "Claw of the Savage Spirit", "Spirit-Shorn Daws",
    "Kerasian Axe of Spite", "Vengeful Taelosian Blood Axe",
    "Water Sprinkler of Nem Ankh", "Aegis of Divine Light",
    "Nature Walker's Scimitar", "Staff of Everliving Brambles",
    "Staff of the Serpent", "Staff of Phenomenal Power",
    "Scythe of the Shadowed Soul", "Focus of Elemental Binding", "Deathwhisper",
    "Celestial Fists", "Transcended Fistwraps of Obscurity",
    "Fiery Defender", "Redemption",
    "Swiftwind", "Earthcaller", "Aurora, the Morning Star",
    "Ragebringer", "Razor of Shadows",
    "Innoruuk's Curse", "Innoruuk's Dark Blessing", "Innoruuk's Dark Curse",
    "Spear of Fate", "Blessed Spiritstaff of the Heyokah",
    "Jagged Blade of War", "Krelwin's Vedium Sword",
    "Staff of the Flux", "Staff of Prismatic Power", "Staff of the Four"
]

item_results = {}
for name in epic_list:
    # Use LIKE for loose matching on spaces or special chars
    search_name = name.replace("'", "%").replace(" ", "%")
    query = f"SELECT id, name FROM items WHERE name LIKE '{search_name}%';"
    item_results[name] = run_query(query)

with open('epic_research_v2.json', 'w') as f:
    json.dump(item_results, f, indent=4)

print("Comprehensive Epic research complete.")

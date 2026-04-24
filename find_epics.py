
import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

epic_names = [
    "Singing Short Sword",          # Bard
    "Claw of the Savage Spirit",    # Beastlord
    "Water Sprinkler of Nem Ankh",  # Cleric
    "Nature Walker's Scimitar",     # Druid
    "Staff of the Serpent",         # Enchanter
    "Orb of Elemental Mastery",     # Magician
    "Celestial Fists",              # Monk
    "Scythe of the Shadowed Soul",  # Necromancer
    "Fiery Defender",               # Paladin
    "Swiftwind",                    # Ranger
    "Earthcaller",                  # Ranger
    "Ragebringer",                  # Rogue
    "Innoruuk's Curse",             # Shadow Knight
    "Spear of Fate",                # Shaman
    "Jagged Blade of War",          # Warrior
    "Blade of Strategy",            # Warrior
    "Blade of Tactics",             # Warrior
    "Staff of the Flux",            # Wizard (Staff of the Four is the actual epic)
    "Staff of the Four"             # Wizard
]

item_results = {}
for name in epic_names:
    query = f"SELECT id, name FROM items WHERE name = '{name}';"
    item_results[name] = run_query(query)

with open('epic_research.json', 'w') as f:
    json.dump(item_results, f, indent=4)

print("Epic research complete.")

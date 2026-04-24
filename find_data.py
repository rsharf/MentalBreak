
import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

classes = {
    "Bard": "Rizlona",
    "Beastlord": "Dumul",
    "Cleric": "Ultor",
    "Druid": "Kerasha",
    "Enchanter": "Romar",
    "Magician": "Magi`Kot",
    "Monk": "Ton Po",
    "Necromancer": "Miragul",
    "Paladin": "Trydan",
    "Ranger": "Askr",
    "Rogue": "Bidilis",
    "Shadow Knight": "Grimror",
    "Shaman": "Rosrak",
    "Warrior": "Raex",
    "Wizard": "Maelin"
}

item_results = {}
for cls, search in classes.items():
    query = f"SELECT id, name FROM items WHERE name LIKE '%{search}%';"
    item_results[cls] = run_query(query)

zone_query = "SELECT short_name, long_name, zoneidnumber FROM zone WHERE long_name LIKE '%Knowledge%';"
zone_result = run_query(zone_query)

with open('research_results.json', 'w') as f:
    json.dump({"items": item_results, "zone": zone_result}, f, indent=4)

print("Research complete. Results saved to research_results.json")

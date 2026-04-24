import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# 1. Get all zones from classic and kunark
query = """
SELECT n.id, n.name, s2.zone 
FROM npc_types n
JOIN spawnentry se ON n.id = se.npcID
JOIN spawngroup sg ON se.spawngroupID = sg.id
JOIN spawn2 s2 ON sg.id = s2.spawngroupID
JOIN zone z ON s2.zone = z.short_name
WHERE z.expansion <= 1
GROUP BY n.id, n.name, s2.zone;
"""

output = run_query(query)
lines = output.strip().split('\n')[1:] # skip header

zones_spawns = {}
for line in lines:
    parts = line.split('\t')
    if len(parts) == 3:
        npc_id, name, zone_name = parts
        if zone_name not in zones_spawns:
            zones_spawns[zone_name] = []
        zones_spawns[zone_name].append({'id': npc_id, 'name': name})

fabled_pairs = []
for zone, spells in zones_spawns.items():
    fabled_npcs = [n for n in spells if "fabled" in n['name'].lower()]
    for f in fabled_npcs:
        base_name_options = [
            f['name'].replace('The_Fabled_', ''),
            f['name'].replace('_The_Fabled_', ''),
            f['name'].replace('#The_Fabled_', '#'),
            f['name'].replace('Fabled_', '')
        ]
        
        base_matches = []
        for n in spells:
            if n['id'] == f['id']: continue
            if n['name'] in base_name_options:
                base_matches.append(n)
            elif n['name'].strip('#') in [b.strip('#') for b in base_name_options]:
                base_matches.append(n)
                
        if base_matches:
            fabled_pairs.append({
                'zone': zone,
                'fabled': f,
                'base': base_matches
            })

with open('fabled_pairs.json', 'w') as f:
    json.dump(fabled_pairs, f, indent=4)

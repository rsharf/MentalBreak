import subprocess
import json
import re

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# 1. Grab ALL fabled npcs
fabled_q = "SELECT id, name FROM npc_types WHERE name LIKE '%Fabled%';"
out = run_query(fabled_q)
fabled_npcs = []
for line in out.strip().split('\n')[1:]:
    parts = line.split('\t')
    if len(parts) == 2:
        fabled_npcs.append({"id": int(parts[0]), "name": parts[1]})

# 2. Get all base npcs spawning in Classic/Kunark
base_q = """
SELECT n.id, n.name, s2.zone, z.expansion
FROM npc_types n
JOIN spawnentry se ON n.id = se.npcID
JOIN spawngroup sg ON se.spawngroupID = sg.id
JOIN spawn2 s2 ON sg.id = s2.spawngroupID
JOIN zone z ON s2.zone = z.short_name
WHERE z.expansion <= 1
GROUP BY n.id, n.name, s2.zone, z.expansion;
"""
out_base = run_query(base_q)
base_spawns = []
for line in out_base.strip().split('\n')[1:]:
    parts = line.split('\t')
    if len(parts) == 4:
        base_spawns.append({"id": int(parts[0]), "name": parts[1], "zone": parts[2], "exp": parts[3]})

# Pair them up
all_pairs = []
for f in fabled_npcs:
    # Build list of possible base names
    fname = f['name']
    opts = [
        fname.replace('The_Fabled_', ''),
        fname.replace('_The_Fabled_', ''),
        fname.replace('#The_Fabled_', '#'),
        fname.replace('Fabled_', '')
    ]
    opts.extend([o.strip('#') for o in opts])
    opts = list(set(opts))
    
    # Check if we have a base spawn in classic/kunark matching
    bases_for_this_fabled = []
    zone_set = set()
    for b in base_spawns:
        if b['name'] in opts or b['name'].strip('#') in opts:
            bases_for_this_fabled.append(b)
            zone_set.add(b['zone'])
            
    if bases_for_this_fabled:
        # Group by zone just in case
        for z in zone_set:
            local_bases = [b for b in bases_for_this_fabled if b['zone'] == z]
            all_pairs.append({
                "fabled": f,
                "base": local_bases,
                "zone": z
            })

# We previously had 16. Let's see what this finds block by block.
fabled_dict = {}
for p in all_pairs:
    fabled_name = p['fabled']['name']
    if fabled_name not in fabled_dict:
        fabled_dict[fabled_name] = p
    else:
        # append base if different?
        pass

with open('all_classic_kunark_fabled.json', 'w') as fh:
    json.dump(list(fabled_dict.values()), fh, indent=4)
print(f"Found {len(fabled_dict)} Fabled NPCs in Classic & Kunark.")

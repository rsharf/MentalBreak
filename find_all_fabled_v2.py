import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

fabled_q = "SELECT id, name FROM npc_types WHERE name LIKE '%Fabled%';"
out = run_query(fabled_q)
fabled_npcs = []
for line in out.strip().split('\n')[1:]:
    parts = line.split('\t')
    if len(parts) == 2:
        fabled_npcs.append({"id": int(parts[0]), "name": parts[1]})

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

all_pairs = []
for f in fabled_npcs:
    fname = f['name'].lower()
    # Strip common prefixes
    stripped = fname.replace('the_fabled_', '').replace('_the_fabled_', '').replace('#the_fabled_', '').replace('fabled_', '').strip('#')
    
    opts = [
        stripped,
        "a_" + stripped,
        "an_" + stripped,
        "#" + stripped
    ]
    
    bases_for_this_fabled = []
    zone_set = set()
    for b in base_spawns:
        if b['name'].lower() in opts or b['name'].lower().strip('#') in opts:
            # exclude if the base IS the fabled
            if "fabled" not in b['name'].lower():
                bases_for_this_fabled.append(b)
                zone_set.add(b['zone'])
                
    if bases_for_this_fabled:
        # Group by zone just in case
        for z in zone_set:
            local_bases = [b for b in bases_for_this_fabled if b['zone'] == z]
            # take one base per zone to avoid massive dupe arrays
            b_ids = []
            final_local = []
            for lb in local_bases:
                if lb['id'] not in b_ids:
                    final_local.append(lb)
                    b_ids.append(lb['id'])
            
            all_pairs.append({
                "fabled": f,
                "base": final_local,
                "zone": z
            })
    else:
        # If no bases found, maybe it's in the DB but not spawning, e.g. Venril Sathir
        # Let's search the full npc_types for a match
        q2 = f"SELECT id, name FROM npc_types WHERE name LIKE '%{stripped}%' AND name NOT LIKE '%Fabled%';"
        out2 = run_query(q2)
        candidates = []
        for line in out2.strip().split('\n')[1:]:
            parts = line.split('\t')
            if len(parts) == 2:
                candidates.append({"id": int(parts[0]), "name": parts[1], "zone": "unassigned", "exp": "?"})
        
        # filter those candidates by name strictly
        strict_c = []
        for c in candidates:
            if c['name'].lower() in opts or c['name'].lower().strip('#') in opts:
                strict_c.append(c)
                
        if strict_c:
            all_pairs.append({
                "fabled": f,
                "base": strict_c,
                "zone": "unassigned_but_in_db"
            })

with open('all_classic_kunark_fabled_v2.json', 'w') as fh:
    json.dump(all_pairs, fh, indent=4)
print(f"Found {len(all_pairs)} Fabled pairings.")

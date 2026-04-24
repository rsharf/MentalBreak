import json
import os
import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

pairs_file = 'all_classic_kunark_fabled_v2.json'
quests_dir = r'd:\app ideas\MentalBreak\eqemu server\eqemu\quests'

with open(pairs_file, 'r') as f:
    pairs = json.load(f)

fabled_ids = []
queries = []

for pair in pairs:
    fabled_id = pair['fabled']['id']
    fabled_name = pair['fabled']['name']
    fabled_ids.append(fabled_id)
    
    zone = pair['zone']
    if zone == 'unassigned_but_in_db':
        zone = 'global'
    
    zone_dir = os.path.join(quests_dir, zone)
    os.makedirs(zone_dir, exist_ok=True)
    
    for base in pair['base']:
        base_id = base['id']
        base_name = base['name'].replace('#', '')
        
        script_content = f"""-- Auto-generated Fabled Controller Script
-- {base['name']} ({base_id}) Spawns {fabled_name} (ID: {fabled_id}) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "{fabled_id}")
    end
end
"""
        lua_path = os.path.join(zone_dir, f"{base_name}.lua")
        
        # If it exists, append to it cautiously
        if os.path.exists(lua_path):
            with open(lua_path, 'r') as lf:
                content = lf.read()
            if "event_death_complete" in content:
                if "999999" not in content and str(fabled_id) not in content:
                    with open(lua_path, 'a') as lf:
                        lf.write(f"\n-- Missing Fabled Spawner hook attached natively below:\n")
                        lf.write(script_content)
            else:
                with open(lua_path, 'a') as lf:
                    lf.write("\n" + script_content)
        else:
            with open(lua_path, 'w') as lf:
                lf.write(script_content)

# 1. Delete spawn entries so they do not spawn naturally
fabled_id_str = ','.join(map(str, set(fabled_ids)))
if fabled_id_str:
    queries.append(f"DELETE FROM spawnentry WHERE npcID IN ({fabled_id_str});")
    
    # 2. Update their loot drop tables to force mindrop >= 1
    # Eqemu parses mindrop locally. We use loottable_entries
    queries.append(f"""
    UPDATE loottable_entries lte
    JOIN npc_types n ON n.loottable_id = lte.loottable_id
    JOIN lootdrop ld ON lte.lootdrop_id = ld.id
    SET lte.mindrop = GREATEST(lte.mindrop, 1),
        lte.droplimit = GREATEST(lte.droplimit, 1)
    WHERE n.id IN ({fabled_id_str})
    AND ld.name LIKE '%fabled%';
    """)

for q in queries:
    run_query(q)

print(f"Deployment complete. Luas generated, spawn entries wiped, and {len(set(fabled_ids))} Fabled Mobs updated for mindrop >= 1.")

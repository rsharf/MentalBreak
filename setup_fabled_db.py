import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

spawner_id = 999999

q_check = f"SELECT id FROM npc_types WHERE id = {spawner_id};"
out_check = run_query(q_check)

queries = []

if str(spawner_id) not in out_check:
    # insert invisible spawner
    queries.append(f"""
    INSERT INTO npc_types (id, name, level, max_hp, race, class, bodytype, npc_spells_id, d_melee_texture1, trackable, targetable, invul, npc_aggro) 
    VALUES ({spawner_id}, 'Fabled_Spawner', 1, 100, 127, 1, 11, 0, 0, 0, 0, 1, 0);
    """)

# Fabled IDs matching the 16 pairs
fabled_ids = [
    13118, 12169, 2148, 5134, 16034, 33157, 44105, 44106, 58057, 
    63096, 68246, 68249, 69135, 89191, 89192, 103218
]

for fid in fabled_ids:
    queries.append(f"DELETE FROM spawnentry WHERE npcID = {fid};")

for q in queries:
    run_query(q)

print(f"Spawner ID {spawner_id} created/verified. Fabled normal spawns removed.")

import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

fabled_ids = [
    13118, 12169, 2148, 5134, 16034, 33157, 44105, 44106, 58057, 
    63096, 68246, 68249, 69135, 89191, 89192, 103218
]

query = f"""
SELECT n.id, n.name, lde.item_id, lde.chance, i.name as item_name
FROM npc_types n
JOIN loottable_entries lte ON n.loottable_id = lte.loottable_id
JOIN lootdrop_entries lde ON lte.lootdrop_id = lde.lootdrop_id
JOIN items i ON lde.item_id = i.id
WHERE n.id IN ({','.join(map(str, fabled_ids))});
"""

print(run_query(query))

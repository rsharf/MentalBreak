import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Look up Fabled King Xorbb (16034)
query = """
SELECT lt.id as lt_id, lte.lootdrop_id as ld_id, lte.probability, ld.name as ld_name
FROM npc_types n
JOIN loottable lt ON n.loottable_id = lt.id
JOIN loottable_entries lte ON lt.id = lte.loottable_id
JOIN lootdrop ld ON lte.lootdrop_id = ld.id
WHERE n.id = 16034;
"""
print("Loottables attached to 16034:")
print(run_query(query))

query2 = """
SELECT lde.item_id, lde.chance, i.name as item_name
FROM npc_types n
JOIN loottable_entries lte ON n.loottable_id = lte.loottable_id
JOIN lootdrop_entries lde ON lte.lootdrop_id = lde.lootdrop_id
JOIN items i ON lde.item_id = i.id
WHERE n.id = 16034;
"""
print("Items dropped by 16034:")
print(run_query(query2))

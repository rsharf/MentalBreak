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

# Update the mindrop and droplimit for the specific fabled lootdrops
update_query = f"""
UPDATE loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id
JOIN lootdrop ld ON lte.lootdrop_id = ld.id
SET lte.mindrop = GREATEST(lte.mindrop, 1),
    lte.droplimit = GREATEST(lte.droplimit, 1)
WHERE n.id IN ({','.join(map(str, fabled_ids))})
AND ld.name LIKE '%fabled%';
"""

print(run_query(update_query))

print("Mindrop updated to at least 1 for all Fabled loot tables.")

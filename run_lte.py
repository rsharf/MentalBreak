import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

query = """
SELECT n.id as npc_id, lte.loottable_id, lte.lootdrop_id, lte.multiplier, lte.droplimit, lte.mindrop, lte.probability, ld.name as drop_name 
FROM npc_types n 
JOIN loottable_entries lte ON n.loottable_id = lte.loottable_id 
JOIN lootdrop ld ON lte.lootdrop_id = ld.id 
WHERE n.id IN (13118, 12169, 2148, 5134, 16034, 33157, 44105, 44106, 58057, 63096, 68246, 68249, 69135, 89191, 89192, 103218) 
AND ld.name LIKE '%fabled%';
"""
with open('fabled_lte.txt', 'w', encoding='utf-8') as f:
    f.write(run_query(query))

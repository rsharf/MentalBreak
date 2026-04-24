import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q1 = "SELECT id, name FROM npc_types WHERE name LIKE 'Instances_%' AND name LIKE '%paw%';"
print("Portal NPCs for paw:")
print(run_query(q1))

q2 = "SELECT id, name FROM zone WHERE short_name = 'paw';"
print("Zone Info:")
print(run_query(q2))

q3 = """
SELECT nt.name, COUNT(DISTINCT nt.id) AS copies
FROM spawnentry se
JOIN npc_types nt ON se.npcID = nt.id
JOIN spawn2 s2 ON s2.spawngroupID = se.spawngroupID
WHERE s2.zone = 'paw' AND s2.version = 0 AND nt.loottable_id > 0
GROUP BY nt.name ORDER BY copies ASC, MAX(nt.level) DESC;
"""
print("Named NPCs in paw:")
print(run_query(q3))


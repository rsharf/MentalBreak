import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q1 = """
SELECT s2.id, n.id as npc_id, n.name, s2.x, s2.y, s2.z, s2.version
FROM spawn2 s2
JOIN spawnentry se ON s2.spawngroupID = se.spawngroupID
JOIN npc_types n ON se.npcID = n.id
WHERE s2.zone = 'paw' AND n.name = 'Instance_Portal';
"""
print("Portal spawns for paw:")
print(run_query(q1))

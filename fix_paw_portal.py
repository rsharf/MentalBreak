import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Move Instance_Portal to zone-in
q1 = """
UPDATE spawn2 s2
JOIN spawnentry se ON s2.spawngroupID = se.spawngroupID
JOIN npc_types n ON se.npcID = n.id
SET s2.x = -7.9, s2.y = -79.3, s2.z = 4, s2.heading = 120
WHERE s2.zone = 'paw' AND n.name = 'Instance_Portal';
"""
print("Moving Portal...")
print(run_query(q1))

# Also update zone safe point so the instance script drops them there when entering instance
q2 = "UPDATE zone SET safe_x = -7.9, safe_y = -79.3, safe_z = 4 WHERE short_name = 'paw';"
print("Updating safe point...")
print(run_query(q2))

import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Look at zone points in PAW
q1 = "SELECT id, target_zone_id, x, y, z, target_x, target_y, target_z FROM zone_points WHERE zone = 'paw';"
print("Zone Points IN Paw:")
print(run_query(q1))

# Look at doors in PAW
q2 = "SELECT id, name, dest_zone, dest_x, dest_y, dest_z, pos_x, pos_y, pos_z FROM doors WHERE zone = 'paw';"
print("Doors IN Paw:")
print(run_query(q2))

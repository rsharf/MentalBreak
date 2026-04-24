import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q1 = "SELECT id, target_zone_id, x, y, z, target_x, target_y, target_z FROM zone_points WHERE zone = 'paw';"
with open("paw_zone_points.txt", "w") as f:
    f.write(run_query(q1))

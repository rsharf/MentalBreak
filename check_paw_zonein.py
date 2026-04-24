import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q1 = "SELECT id, dest_x, dest_y, dest_z, dest_heading FROM doors WHERE dest_zone = 'paw';"
print(run_query(q1))

q2 = "SELECT id, target_zone_id, target_x, target_y, target_z, target_heading FROM zone_points WHERE target_zone_id = 18;"
print(run_query(q2))

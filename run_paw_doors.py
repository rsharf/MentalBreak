import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q2 = "SELECT id, name, dest_zone, dest_x, dest_y, dest_z, pos_x, pos_y, pos_z FROM doors WHERE zone = 'paw';"
with open("paw_doors.txt", "w") as f:
    f.write(run_query(q2))

import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Revert safe point
q1 = "UPDATE zone SET safe_x = 63.0, safe_y = -122.0, safe_z = 3.0 WHERE short_name = 'paw';"
print("Reverting safe point...")
print(run_query(q1))

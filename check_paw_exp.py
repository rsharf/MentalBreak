import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

q1 = "SELECT id, short_name, expansion FROM zone WHERE short_name = 'paw';"
print(run_query(q1))

q2 = "SELECT count(*) FROM spawn2 WHERE zone='paw' AND version=100;"
print(run_query(q2))

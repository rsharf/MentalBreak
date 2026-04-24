import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Look up original safe coordinates of Paw. Oh wait, I overwrote them. I can check by reverting.
# Southkarana is 14. 
q1 = "SELECT short_name, safe_x, safe_y, safe_z FROM zone WHERE short_name IN ('paw', 'southkarana');"
print(run_query(q1))

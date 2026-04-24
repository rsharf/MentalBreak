import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

query = """
SELECT id, name 
FROM npc_types 
WHERE name LIKE '%Venril%Sathir%' OR name LIKE '%Fabled%Venril%';
"""

print(run_query(query))

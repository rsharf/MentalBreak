import subprocess

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

query = """
SELECT id, name FROM npc_types WHERE name LIKE '%Cazic_Thule%' OR name LIKE '%Fabled%';
"""
out = run_query(query)
with open('cazic_test.txt', 'w', encoding='utf-8') as f:
    for line in out.splitlines():
        if "Cazic" in line or "Thule" in line:
            f.write(line + "\n")

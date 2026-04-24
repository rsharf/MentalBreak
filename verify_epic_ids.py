
import subprocess
import json

def run_query(query):
    mysql_exe = r'C:\Program Files\MariaDB 10.11\bin\mysql.exe'
    cmd = [mysql_exe, '-uroot', '-p1', '-D', 'peq', '-e', query]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

ids_to_check = [
    20542, 77640, 8495, 62581, 18608, 18609, 5532, 63456, 20490, 62880, 10650, 16576, 20544, 64024, 10652, 67741, 64067, 10099, 64031, 20487, 20488, 62649, 11057, 62601, 14383, 48136, 10651, 57405, 10908, 18607, 6342, 12665
]

query = f"SELECT id, name FROM items WHERE id IN ({','.join(map(str, ids_to_check))});"
result = run_query(query)
print(result)

# Also search for "Spirit-Shorn Daws" and others with looser names
print("Searching for Spirit-Shorn Daws...")
print(run_query("SELECT id, name FROM items WHERE name LIKE '%Spirit%Shorn%Daws%';"))
print("Searching for Aegis of Divine Light...")
print(run_query("SELECT id, name FROM items WHERE name LIKE '%Aegis%Divine%Light%';"))
print("Searching for Focus of Elemental Binding...")
print(run_query("SELECT id, name FROM items WHERE name LIKE '%Focus%Elemental%Binding%';"))
print("Searching for Krelwin...")
print(run_query("SELECT id, name FROM items WHERE name LIKE '%Krelwin%';"))
print("Searching for Aurora...")
print(run_query("SELECT id, name FROM items WHERE name LIKE '%Aurora%';"))

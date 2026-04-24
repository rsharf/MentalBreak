import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq')
    with db.cursor() as cur:
        # Check spawns in version 100 for paw
        cur.execute("""
            SELECT COUNT(*), MIN(n.level), MAX(n.level)
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND s.version = 100
        """)
        print("Version 100 (Current Instance) Spawns:", cur.fetchone())

        # Check named in version 1
        cur.execute("""
            SELECT n.name, n.level
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND s.version = 1
        """)
        names1 = cur.fetchall()
        print(f"Version 1 (Infected Paw) Spawns Count: {len(names1)}")
        print("Version 1 samples:", names1[:5])
        
        # Check named in version 0
        cur.execute("""
            SELECT n.name, n.level
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND s.version = 0
            LIMIT 5
        """)
        names0 = cur.fetchall()
        print(f"Version 0 (Classic Paw) samples:", names0)

except Exception as e:
    print(f"Error: {e}")

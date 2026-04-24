import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq')
    with db.cursor() as cur:
        # Search for the NPC
        cur.execute("SELECT id, name FROM npc_types WHERE name LIKE '%gillamina%' OR name LIKE '%garstobidokis%' OR name LIKE '%paw%';")
        print("--- NPCs matching 'gillamina' or 'paw' ---")
        for row in cur.fetchall():
            if 'paw' not in row[1].lower() or 'gillamina' in row[1].lower() or 'garstobidokis' in row[1].lower(): # avoid dumping all paws if there are many, wait let's just dump first 20
                 pass
            print(row)
            
        cur.execute("SELECT id, name FROM npc_types WHERE name LIKE '%gillamina%' OR name LIKE '%garstobidokis%';")
        print("--- Exact Gillamina matches ---")
        npcs = cur.fetchall()
        for row in npcs:
            print(row)
            
            # Find spawns for this NPC
            cur.execute("""
                SELECT s.id, s.zone, s.x, s.y, s.z 
                FROM spawn2 s
                JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
                WHERE se.npcID = %s
            """, (row[0],))
            print(f"Spawns for {row[1]} ({row[0]}):")
            for spawn in cur.fetchall():
                print(spawn)
                
            cur.execute("""
                SELECT s.id, s.zone, s.x, s.y, s.z, n.name
                FROM spawn2 s
                JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
                JOIN npc_types n ON se.npcID = n.id
                WHERE s.zone = 'paw' AND n.name LIKE '%instance%'
            """)
            print(f"Other instance NPCs in paw:")
            for spawn in cur.fetchall():
                print(spawn)

except Exception as e:
    print(f"Error: {e}")

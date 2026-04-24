import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq')
    with db.cursor() as cur:
        # Find named mobs in paw version 1
        cur.execute("""
            SELECT nt.id, nt.name, nt.level, COUNT(DISTINCT s2.id) AS copies,
                   MAX(s2.x), MAX(s2.y), MAX(s2.z), MAX(s2.heading)
            FROM spawnentry se
            JOIN npc_types nt ON se.npcID = nt.id
            JOIN spawn2 s2 ON s2.spawngroupID = se.spawngroupID
            WHERE s2.zone = 'paw' AND s2.version = 1 AND nt.loottable_id > 0
            GROUP BY nt.name 
            HAVING copies <= 2
            ORDER BY copies ASC, MAX(nt.level) DESC
        """)
        named = cur.fetchall()
        print(f"Found {len(named)} named NPCs in paw version 1:")
        for r in named:
             print(f"{r[1]} (L{r[2]}) - Copies: {r[3]}")

except Exception as e:
    print(f"Error: {e}")

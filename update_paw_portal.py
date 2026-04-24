import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq', autocommit=True)
    with db.cursor() as cur:
        # Get Gillamina's location
        cur.execute("""
            SELECT s.x, s.y, s.z, s.heading
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            WHERE se.npcID = 18001 AND s.zone = 'paw'
            LIMIT 1
        """)
        gillamina = cur.fetchone()
        
        # Get Instance_Portal's id
        cur.execute("""
            SELECT s.id, s.x, s.y, s.z, s.heading
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND n.name = 'Instance_Portal'
        """)
        portal = cur.fetchone()
        
        print(f"Gillamina current location: x={gillamina[0]}, y={gillamina[1]}, z={gillamina[2]}, heading={gillamina[3]}")
        print(f"Portal current location: x={portal[1]}, y={portal[2]}, z={portal[3]}, heading={portal[4]}")
        
        # Calculate new location (slightly off from Gillamina)
        new_x = gillamina[0] + 5
        new_y = gillamina[1]
        new_z = gillamina[2]
        new_h = gillamina[3]
        
        print(f"Updating portal to: x={new_x}, y={new_y}, z={new_z}, heading={new_h}")
        
        cur.execute("""
            UPDATE spawn2 
            SET x = %s, y = %s, z = %s, heading = %s
            WHERE id = %s
        """, (new_x, new_y, new_z, new_h, portal[0]))
        print("Done!")

except Exception as e:
    print(f"Error: {e}")

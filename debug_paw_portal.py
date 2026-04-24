import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq')
    with db.cursor(pymysql.cursors.DictCursor) as cur:
        # Find Instance_Portal in paw
        cur.execute("""
            SELECT s.* 
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND n.name = 'Instance_Portal'
        """)
        s_row = cur.fetchone()
        print("SPAWN2 ROW:", s_row)
        
        if s_row:
            cur.execute("SELECT * FROM spawngroup WHERE id = %s", (s_row['spawngroupID'],))
            sg_row = cur.fetchone()
            print("SPAWNGROUP ROW:", sg_row)
            
            cur.execute("SELECT * FROM spawnentry WHERE spawngroupID = %s", (s_row['spawngroupID'],))
            se_rows = cur.fetchall()
            print("SPAWNENTRY ROWS:", se_rows)

        cur.execute("SELECT x, y, z FROM spawn2 WHERE zone = 'paw' AND spawngroupID IN (SELECT id FROM spawngroup WHERE name = 'Gillamina_Garstobidokis')")
        gill = cur.fetchone()
        print("Gillamina:", gill)

except Exception as e:
    print(f"Error: {e}")

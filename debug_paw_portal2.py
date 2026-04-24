import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq', autocommit=True)
    with db.cursor(pymysql.cursors.DictCursor) as cur:
        # Check Gillamina
        cur.execute("""
            SELECT s.* 
            FROM spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            WHERE s.zone = 'paw' AND n.name = '#Gillamina_Garstobidokis'
        """)
        print("Gillamina SPAWN2:", cur.fetchone())
        
        # We need to see condition_value_filter for Gillamina's spawn_entry
        cur.execute("""
            SELECT se.*, sg.spawn_limit
            FROM spawnentry se
            JOIN spawngroup sg ON se.spawngroupID = sg.id
            JOIN npc_types n ON se.npcID = n.id
            WHERE n.name = '#Gillamina_Garstobidokis'
        """)
        print("Gillamina ENTRY & GROUP:", cur.fetchone())

except Exception as e:
    print(f"Error: {e}")

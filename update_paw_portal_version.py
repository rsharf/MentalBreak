import pymysql

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq', autocommit=True)
    with db.cursor() as cur:
        # Update Instance_Portal in paw to version 1
        cur.execute("""
            UPDATE spawn2 s
            JOIN spawnentry se ON s.spawngroupID = se.spawngroupID
            JOIN npc_types n ON se.npcID = n.id
            SET s.version = 1
            WHERE s.zone = 'paw' AND n.name = 'Instance_Portal'
        """)
        print("Updated Instance_Portal in paw to version 1")

except Exception as e:
    print(f"Error: {e}")

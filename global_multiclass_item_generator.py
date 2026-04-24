#!/usr/bin/env python3
import pymysql
import sys

DB_HOST = "127.0.0.1"
DB_USER = "root"
DB_PASS = "1"
DB_NAME = "peq"

SQL_FILE = r"D:\app ideas\MentalBreak\bound_items.sql"

def main():
    print("Connecting to database...")
    try:
        conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASS, db=DB_NAME, cursorclass=pymysql.cursors.DictCursor)
    except Exception as e:
        print(f"Error connecting: {e}")
        sys.exit(1)

    try:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT * FROM items 
                WHERE slots > 0 
                AND id < 2000000
                AND (classes != 65535 OR races != 65535)
            """)
            items = cur.fetchall()
            
            print(f"Found {len(items)} equippable items with class/race restrictions.")
            
            cur.execute("SHOW COLUMNS FROM items")
            columns = [row['Field'] for row in cur.fetchall()]
            
        print("Generating SQL...")
        with open(SQL_FILE, "w", encoding="utf-8") as f:
            f.write("-- Auto-generated Bound Items for Multiclassing\n")
            f.write("-- Prefix: 'Bound ', Classes: ALL, Races: ALL, NoDrop: 0\n\n")
            
            f.write("DELETE FROM items WHERE id >= 2000000 AND id < 4000000 AND Name LIKE 'Bound %';\n\n")
            
            batch_size = 500
            batch = []
            
            for item in items:
                new_item = item.copy()
                new_item['id'] = item['id'] + 2000000
                
                # Handle case-insensitive dict keys
                base_name = new_item.get('name') or new_item.get('Name') or "Unknown"
                if len(base_name) > 58:
                    base_name = base_name[:58]
                
                if 'Name' in new_item:
                    new_item['Name'] = f"Bound {base_name}"
                else:
                    new_item['name'] = f"Bound {base_name}"
                
                new_item['classes'] = 65535
                new_item['races'] = 65535
                new_item['nodrop'] = 0
                new_item['attuneable'] = 0
                new_item['magic'] = 1
                
                vals = []
                for col in columns:
                    val = new_item.get(col)
                    if val is None:
                        vals.append("NULL")
                    elif isinstance(val, str):
                        escaped = val.replace("\\", "\\\\").replace("'", "\\'")
                        vals.append(f"'{escaped}'")
                    elif hasattr(val, 'strftime'):
                        vals.append(f"'{val.strftime('%Y-%m-%d %H:%M:%S')}'")
                    else:
                        vals.append(str(val))
                
                batch.append(f"({','.join(vals)})")
                
                if len(batch) >= batch_size:
                    col_str = ', '.join([f'`{c}`' for c in columns])
                    f.write(f"INSERT INTO items ({col_str}) VALUES\n")
                    f.write(",\n".join(batch) + ";\n\n")
                    batch = []
            
            if batch:
                col_str = ', '.join([f'`{c}`' for c in columns])
                f.write(f"INSERT INTO items ({col_str}) VALUES\n")
                f.write(",\n".join(batch) + ";\n\n")
                
        print(f"SQL file generated at: {SQL_FILE}")
        
    finally:
        conn.close()

if __name__ == "__main__":
    main()

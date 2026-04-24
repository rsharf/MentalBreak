import pymysql
import os

try:
    db = pymysql.connect(host='127.0.0.1', user='root', password='1', db='peq', autocommit=True)
    with db.cursor() as cur:
        # Find named mobs in paw version 1
        cur.execute("""
            SELECT nt.id, nt.name, nt.level,
                   MAX(s2.x), MAX(s2.y), MAX(s2.z), MAX(s2.heading)
            FROM spawnentry se
            JOIN npc_types nt ON se.npcID = nt.id
            JOIN spawn2 s2 ON s2.spawngroupID = se.spawngroupID
            WHERE s2.zone = 'paw' AND s2.version = 1 AND nt.loottable_id > 0
            GROUP BY nt.name 
            HAVING COUNT(DISTINCT s2.id) <= 2
            ORDER BY MAX(nt.level) DESC
        """)
        named = cur.fetchall()
        
        base_sg = 3294800
        base_s2 = 3274800
        
        boss_id = 0
        boss_name = ""
        
        # Clean up in case script was run before
        cur.execute("DELETE FROM spawn2 WHERE id >= 3274800 AND id < 3274900")
        cur.execute("DELETE FROM spawnentry WHERE spawngroupID >= 3294800 AND spawngroupID < 3294900")
        cur.execute("DELETE FROM spawngroup WHERE id >= 3294800 AND id < 3294900")
        
        print(f"Creating SQL for {len(named)} named mobs in version 101...")
        for i, row in enumerate(named):
            npc_id, name, level, x, y, z, h = row
            sg_id = base_sg + i
            s2_id = base_s2 + i
            
            # Select highest level mob as boss for lockout
            if boss_id == 0 and name == '#Overlord_Flargor':
                boss_id = npc_id
                boss_name = name
            
            # Insert Spawngroup
            cur.execute("""
                INSERT INTO spawngroup (id, name, spawn_limit, mindelay)
                VALUES (%s, %s, 0, 15000)
            """, (sg_id, f"inst_paw_v2_{name}"))
            
            # Insert Spawnentry
            cur.execute("""
                INSERT INTO spawnentry (spawngroupID, npcID, chance, condition_value_filter)
                VALUES (%s, %s, 100, 1)
            """, (sg_id, npc_id))
            
            # Insert Spawn2
            cur.execute("""
                INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime)
                VALUES (%s, %s, 'paw', 101, %s, %s, %s, %s, 86400)
            """, (s2_id, sg_id, x, y, z, h))
            print(f"Created instance spawn for {name} ({npc_id}) at {x}, {y}, {z}")

        # If overlord flargor wasn't found, pick the first L73
        if boss_id == 0 and named:
            boss_id = named[0][0]
            boss_name = named[0][1]

        # Generate instance_boss_v2.lua
        lua_content = f"""-- Infected Paw Instance Encounter (version 101)
-- Named NPCs spawn via database spawn2 (version=101)
-- Lockout set on {boss_name} (ID {boss_id}) death

function Boss_Death(e)
    eq.set_global("inst_paw2_lockout", tostring(os.time()), 2, "H24")
    local cl = eq.get_entity_list():GetClientList()
    for c in cl.entries do
        if c.valid then
            c:Message(15, "Infected Paw instance complete! You may return in 24 hours.")
        end
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == 101 then
        e.self:GMMove(19.0, -137.0, 4.0, 0) -- Near entrance of Infected Paw
    end
end

function event_encounter_load(e)
    eq.register_npc_event('instance_boss_v2', Event.death_complete, {boss_id}, Boss_Death)
    eq.register_player_event('instance_boss_v2', Event.enter_zone, Zone_Entry)
end
"""
        with open(r"d:\app ideas\MentalBreak\eqemu server\eqemu\quests\paw\encounters\instance_boss_v2.lua", "w", encoding="utf-8") as f:
            f.write(lua_content)
        print("Wrote instance_boss_v2.lua")

except Exception as e:
    print(f"Error: {e}")

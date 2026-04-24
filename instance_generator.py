#!/usr/bin/env python3
"""
Instance Generator for MentalBreak EQEmu Custom Server
Generates solo instance infrastructure for all Classic/Kunark/Velious zones.
Outputs: SQL file, per-zone Lua encounter scripts, portal NPC scripts, script_init.lua files.
"""

import os
import re
import pymysql

# ── Configuration ──────────────────────────────────────────────────────────────
DB_HOST = "127.0.0.1"
DB_PORT = 3306
DB_USER = "root"
DB_PASS = "1"
DB_NAME = "peq"

QUEST_BASE = r"D:\app ideas\MentalBreak\eqemu server\eqemu\quests"
SQL_OUTPUT = r"D:\app ideas\MentalBreak\instance_all_zones.sql"

# ID allocation bases
PORTAL_NPC_ID_BASE = 2100001       # Portal NPC IDs: 2100001 + zone_index
NAMED_SG_BASE      = 3290200       # Spawngroup IDs for named NPCs (running counter)
NAMED_S2_BASE      = 3270200       # Spawn2 IDs for named NPCs (running counter)
PORTAL_SG_BASE     = 3298000       # Spawngroup IDs for portal NPCs (running counter)
PORTAL_S2_BASE     = 3278000       # Spawn2 IDs for portal NPCs (running counter)

INST_VERSION = 100
SKIP_ZONES = {"hateplaneb", "fearplane"}

# ── Helpers ────────────────────────────────────────────────────────────────────

def sanitize_name(name, max_len=50):
    """Sanitize NPC name for spawngroup name usage."""
    s = re.sub(r"[^a-zA-Z0-9_]", "_", name)
    s = re.sub(r"_+", "_", s).strip("_")
    return s[:max_len]

def sql_escape(s):
    """Escape single quotes for SQL strings."""
    return s.replace("'", "''")

def lua_escape(s):
    """Escape a string for use inside Lua double-quoted strings."""
    s = s.replace("\\", "\\\\")
    s = s.replace('"', '\\"')
    return s

def connect_db():
    return pymysql.connect(
        host=DB_HOST, port=DB_PORT, user=DB_USER, password=DB_PASS,
        database=DB_NAME, charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor
    )

# ── Zone Query ─────────────────────────────────────────────────────────────────


def get_special_names(conn):
    print("[INIT] Building Special A-Mobs list...")
    special_names = set()
    
    quest_count = 0
    import os
    for root, dirs, files in os.walk(QUEST_BASE):
        for f in files:
            if f.endswith(".lua") or f.endswith(".pl"):
                name = f[:-4]
                special_names.add(name)
                quest_count += 1
                
    cur = conn.cursor()
    cur.execute("""
        SELECT DISTINCT nt.name
        FROM npc_types nt
        WHERE nt.qglobal = 1
        UNION
        SELECT DISTINCT nt.name
        FROM npc_types nt
        JOIN loottable_entries lte ON nt.loottable_id = lte.loottable_id
        JOIN lootdrop_entries lde ON lte.lootdrop_id = lde.lootdrop_id
        JOIN items i ON lde.item_id = i.id
        WHERE i.magic = 1 AND i.id IN (
            SELECT i2.id FROM items i2
            JOIN lootdrop_entries lde2 ON i2.id = lde2.item_id
            JOIN loottable_entries lte2 ON lde2.lootdrop_id = lte2.lootdrop_id
            JOIN npc_types nt2 ON lte2.loottable_id = nt2.loottable_id
            GROUP BY i2.id HAVING COUNT(DISTINCT nt2.name) <= 2
        )
    """)
    rows = cur.fetchall()
    db_count = len(rows)
    for row in rows:
        special_names.add(row['name'])
        
    print(f"[INIT] Found {quest_count} quest files and {db_count} special loot/qglobal NPCs.")
    print(f"[INIT] Total unique special names: {len(special_names)}\n")
    return special_names

def fetch_zones(conn):

    """Fetch qualifying Classic/Kunark/Velious zones, deduplicated by short_name."""
    cur = conn.cursor()
    cur.execute("""
        SELECT DISTINCT z.short_name, z.zoneidnumber, z.long_name, z.expansion,
               z.safe_x, z.safe_y, z.safe_z
        FROM zone z
        JOIN spawn2 s2 ON s2.zone = z.short_name AND s2.version = 0
        JOIN spawnentry se ON se.spawngroupID = s2.spawngroupID
        JOIN npc_types nt ON se.npcID = nt.id AND nt.loottable_id > 0
        WHERE z.expansion IN (0, 1, 2)

        GROUP BY z.short_name, z.zoneidnumber, z.long_name, z.expansion,
                 z.safe_x, z.safe_y, z.safe_z
        HAVING COUNT(DISTINCT nt.id) >= 3
        ORDER BY z.expansion, z.short_name
    """)
    rows = cur.fetchall()

    # Deduplicate by short_name — keep FIRST row found
    seen = set()
    zones = []
    for row in rows:
        sn = row["short_name"]
        if sn in seen:
            continue
        seen.add(sn)
        if sn in SKIP_ZONES:
            continue
        zones.append(row)

    return zones

# ── NPC Query (per zone) ──────────────────────────────────────────────────────

def fetch_named_npcs(conn, zone_short, special_names):
    """Fetch named NPCs for a zone. Dedup by NPC ID (first coord only)."""
    cur = conn.cursor()
    cur.execute("""
        SELECT DISTINCT nt.id, nt.name, nt.level, nt.hp,
               s2.x, s2.y, s2.z, s2.heading
        FROM npc_types nt
        JOIN spawnentry se ON se.npcID = nt.id
        JOIN spawn2 s2 ON s2.spawngroupID = se.spawngroupID
          AND s2.zone = %s AND s2.version = 0
        WHERE nt.loottable_id > 0

          AND nt.id IN (
              SELECT se2.npcID FROM spawnentry se2
              JOIN spawn2 s22 ON s22.spawngroupID = se2.spawngroupID
              WHERE s22.zone = %s AND s22.version = 0
              GROUP BY se2.npcID HAVING COUNT(DISTINCT se2.spawngroupID) <= 2
          )
        ORDER BY nt.level DESC, nt.hp DESC
    """, (zone_short, zone_short))
    rows = cur.fetchall()

    # Deduplicate by NPC ID — keep first coordinate set
    seen_ids = set()
    npcs = []
    for row in rows:
        npc_id = row["id"]
        if npc_id in seen_ids:
            continue
            
        npc_name_lower = row["name"].lower()
        if npc_name_lower.startswith("a_") or npc_name_lower.startswith("an_"):
            if row["name"] not in special_names:
                continue
                
        # Exclude Fabled mobs so they must be triggered by scripts
        if "fabled" in npc_name_lower:
            continue

        seen_ids.add(npc_id)
        npcs.append(row)

    return npcs

# ── SQL Generation ─────────────────────────────────────────────────────────────

def generate_sql(zones, all_npcs):
    """Generate the master SQL file."""
    lines = []
    lines.append("-- ============================================================")
    lines.append("-- Instance Generator: All Classic/Kunark/Velious Zones")
    lines.append("-- Auto-generated — DO NOT EDIT MANUALLY")
    lines.append("-- ============================================================")
    lines.append("")

    # Cleanup section
    lines.append("-- Cleanup: Remove previously generated instance data")
    portal_ids = [PORTAL_NPC_ID_BASE + i for i in range(len(zones))]
    if portal_ids:
        id_list = ", ".join(str(x) for x in portal_ids)
        lines.append(f"DELETE FROM spawn2 WHERE id >= {NAMED_S2_BASE} AND id < {NAMED_S2_BASE + 100000};")
        lines.append(f"DELETE FROM spawn2 WHERE id >= {PORTAL_S2_BASE} AND id < {PORTAL_S2_BASE + 10000};")
        lines.append(f"DELETE FROM spawnentry WHERE spawngroupID >= {NAMED_SG_BASE} AND spawngroupID < {NAMED_SG_BASE + 100000};")
        lines.append(f"DELETE FROM spawnentry WHERE spawngroupID >= {PORTAL_SG_BASE} AND spawngroupID < {PORTAL_SG_BASE + 10000};")
        lines.append(f"DELETE FROM spawngroup WHERE id >= {NAMED_SG_BASE} AND id < {NAMED_SG_BASE + 100000};")
        lines.append(f"DELETE FROM spawngroup WHERE id >= {PORTAL_SG_BASE} AND id < {PORTAL_SG_BASE + 10000};")
        lines.append(f"DELETE FROM npc_types WHERE id IN ({id_list});")
    lines.append("")

    named_sg_counter = NAMED_SG_BASE
    named_s2_counter = NAMED_S2_BASE
    portal_sg_counter = PORTAL_SG_BASE
    portal_s2_counter = PORTAL_S2_BASE

    total_sql_rows = 0
    total_npcs = 0

    for zone_idx, zone in enumerate(zones):
        sn = zone["short_name"]
        ln = zone["long_name"]
        zone_id = zone["zoneidnumber"]
        safe_x = zone["safe_x"]
        safe_y = zone["safe_y"]
        safe_z = zone["safe_z"]
        portal_npc_id = PORTAL_NPC_ID_BASE + zone_idx
        npcs = all_npcs.get(sn, [])

        lines.append(f"-- ── {sn} ({ln}) ── Portal NPC ID: {portal_npc_id}, Named NPCs: {len(npcs)} ──")
        lines.append("")

        # Portal NPC npc_types
        lines.append(f"INSERT INTO npc_types (id, name, level, hp, race, class, bodytype, size, "
                      f"special_abilities, trackable, findable, qglobal, npc_faction_id) "
                      f"VALUES ({portal_npc_id}, 'Instance_Portal', 50, 100000, 1, 1, 1, 1.0, "
                      f"'35,1^24,1', 1, 1, 1, 0);")
        total_sql_rows += 1

        # Portal spawngroup
        sg_name = f"inst_portal_{sn}"
        lines.append(f"INSERT INTO spawngroup (id, name, spawn_limit, dist, max_x, min_x, max_y, min_y, "
                      f"delay, mindelay, despawn, despawn_timer) "
                      f"VALUES ({portal_sg_counter}, '{sql_escape(sg_name)}', 0, 0, 0, 0, 0, 0, "
                      f"0, 15000, 0, 100);")
        total_sql_rows += 1

        # Portal spawnentry
        lines.append(f"INSERT INTO spawnentry (spawngroupID, npcID, chance) "
                      f"VALUES ({portal_sg_counter}, {portal_npc_id}, 100);")
        total_sql_rows += 1

        # Portal spawn2 (version 0, at safe point)
        lines.append(f"INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, "
                      f"respawntime, variance, pathgrid, _condition, cond_value, animation) "
                      f"VALUES ({portal_s2_counter}, {portal_sg_counter}, '{sql_escape(sn)}', 0, "
                      f"{safe_x}, {safe_y}, {safe_z}, 0, 86400, 0, 0, 0, 1, 0);")
        total_sql_rows += 1

        portal_sg_counter += 1
        portal_s2_counter += 1

        lines.append("")

        # Named NPC spawngroups + spawnentries + spawn2 (version 100)
        for npc in npcs:
            npc_id = npc["id"]
            npc_name = npc["name"]
            npc_name_san = sanitize_name(npc_name)
            sg_name_npc = sanitize_name(f"i_{sn}_{npc_name_san}"[:40] + f"_{npc_id}", 50)
            x = npc["x"]
            y = npc["y"]
            z = npc["z"]
            heading = npc["heading"]

            lines.append(f"INSERT INTO spawngroup (id, name, spawn_limit, dist, max_x, min_x, max_y, min_y, "
                          f"delay, mindelay, despawn, despawn_timer) "
                          f"VALUES ({named_sg_counter}, '{sql_escape(sg_name_npc)}', 0, 0, 0, 0, 0, 0, "
                          f"0, 15000, 0, 100);")
            total_sql_rows += 1

            lines.append(f"INSERT INTO spawnentry (spawngroupID, npcID, chance) "
                          f"VALUES ({named_sg_counter}, {npc_id}, 100);")
            total_sql_rows += 1

            lines.append(f"INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, "
                          f"respawntime, variance, pathgrid, _condition, cond_value, animation) "
                          f"VALUES ({named_s2_counter}, {named_sg_counter}, '{sql_escape(sn)}', {INST_VERSION}, "
                          f"{x}, {y}, {z}, {heading}, 86400, 0, 0, 0, 1, 0);")
            total_sql_rows += 1

            named_sg_counter += 1
            named_s2_counter += 1
            total_npcs += 1

        lines.append("")

    return "\n".join(lines), total_sql_rows, total_npcs

# ── Lua Generation ─────────────────────────────────────────────────────────────

def generate_portal_lua(zone):
    """Generate the portal NPC Lua script."""
    sn = zone["short_name"]
    ln = zone["long_name"]
    zone_id = zone["zoneidnumber"]
    safe_x = zone["safe_x"]
    safe_y = zone["safe_y"]
    safe_z = zone["safe_z"]

    return f"""-- Instance Portal for {ln}
local INST_VERSION = {INST_VERSION}
local INST_DURATION = 86400
local ZONE_SHORT = "{sn}"
local ZONE_ID = {zone_id}
local LOCKOUT = "inst_{sn}_lockout"
local SAFE_X, SAFE_Y, SAFE_Z = {safe_x}, {safe_y}, {safe_z}

function event_say(e)
    local text = string.lower(e.message)
    if string.find(text, "hail") then
        e.self:Say("I can send you to a private instance of {lua_escape(ln)} where all named creatures are waiting. Say 'enter' when you are ready.")
    elseif string.find(text, "enter") then
        enter_instance(e)
    end
end

function enter_instance(e)
    local qglobals = eq.get_qglobals(e.other)
    if qglobals[LOCKOUT] then
        local lockout_set = tonumber(qglobals[LOCKOUT])
        if lockout_set then
            local remaining = INST_DURATION - (os.time() - lockout_set)
            if remaining > 0 then
                local h = math.floor(remaining / 3600)
                local m = math.floor((remaining % 3600) / 60)
                e.self:Say("You must wait " .. h .. "h " .. m .. "m before entering again.")
                return
            end
        end
    end
    local inst_id = eq.get_instance_id(ZONE_SHORT, INST_VERSION)
    if inst_id > 0 and eq.get_instance_timer_by_id(inst_id) > 0 then
        e.self:Say("Returning you to your existing instance...")
        eq.assign_to_instance(inst_id)
        e.other:MovePCInstance(ZONE_ID, inst_id, SAFE_X, SAFE_Y, SAFE_Z, 0)
        return
    end
    inst_id = eq.create_instance(ZONE_SHORT, INST_VERSION, INST_DURATION)
    if inst_id == 0 then
        e.self:Say("Instance creation failed. Try again.")
        return
    end
    eq.assign_to_instance(inst_id)
    e.self:Say("Transporting you now...")
    e.other:MovePCInstance(ZONE_ID, inst_id, SAFE_X, SAFE_Y, SAFE_Z, 0)
end
"""

def generate_encounter_lua(zone, boss_npc):
    """Generate the encounter script for a zone."""
    sn = zone["short_name"]
    ln = zone["long_name"]
    safe_x = zone["safe_x"]
    safe_y = zone["safe_y"]
    safe_z = zone["safe_z"]
    boss_id = boss_npc["id"]
    boss_name = boss_npc["name"]

    return f"""-- {ln} Instance Encounter (version {INST_VERSION})
-- Named NPCs spawn via database spawn2 (version={INST_VERSION})
-- Lockout set on {boss_name} (ID {boss_id}) death

function Boss_Death(e)
    eq.set_global("inst_{sn}_lockout", tostring(os.time()), 2, "H24")
    local cl = eq.get_entity_list():GetClientList()
    for c in cl.entries do
        if c.valid then
            c:Message(15, "Instance complete! You may return in 24 hours.")
        end
    end
end

function Boss_Combat(e)
    if e.joined then
        e.self:Shout("You dare challenge me alone?!")
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == {INST_VERSION} then
        e.self:GMMove({safe_x}, {safe_y}, {safe_z}, 0)
    end
end

function event_encounter_load(e)
    eq.register_npc_event('instance_boss', Event.death_complete, {boss_id}, Boss_Death)
    eq.register_npc_event('instance_boss', Event.combat, {boss_id}, Boss_Combat)
    eq.register_player_event('instance_boss', Event.enter_zone, Zone_Entry)
end
"""

def generate_script_init(zone, quest_dir):
    """Generate or update script_init.lua for a zone."""
    sn = zone["short_name"]
    script_init_path = os.path.join(quest_dir, sn, "script_init.lua")

    instance_block_check = "eq.get_zone_instance_version() == 100"
    instance_load = "    eq.load_encounter('instance_boss')"

    if os.path.exists(script_init_path):
        with open(script_init_path, "r", encoding="utf-8") as f:
            existing = f.read()

        # If already has version 100 block, skip
        if instance_block_check in existing:
            return None, "SKIPPED (already has version 100 block)"

        # Wrap existing content in else block
        # Indent existing content by 4 spaces
        existing_stripped = existing.rstrip("\n")
        existing_lines = existing_stripped.split("\n")
        indented = "\n".join("    " + line if line.strip() else "" for line in existing_lines)

        new_content = f"""if eq.get_zone_instance_version() == 100 then
{instance_load}
else
{indented}
end
"""
        return new_content, "MERGED with existing"
    else:
        new_content = f"""if eq.get_zone_instance_version() == 100 then
{instance_load}
end
"""
        return new_content, "CREATED new"

# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    print("=" * 70)
    print("  MentalBreak Instance Generator")
    print("  Classic / Kunark / Velious Solo Instances")
    print("=" * 70)
    print()

    conn = connect_db()
    print("[DB] Connected to MariaDB")

    # Fetch special names first
    special_names = get_special_names(conn)
    
    # Fetch zones
    zones = fetch_zones(conn)
    print(f"[ZONES] Found {len(zones)} qualifying zones (after dedup & skip)")
    print()

    # Fetch NPCs per zone
    all_npcs = {}
    warnings = []
    for zone in zones:
        sn = zone["short_name"]
        npcs = fetch_named_npcs(conn, sn, special_names)
        if len(npcs) == 0:
            warnings.append(f"  WARNING: {sn} has 0 named NPCs after NPC query (zone query said >= 3)")
        all_npcs[sn] = npcs

    conn.close()
    print(f"[DB] Connection closed")
    print()

    # Generate SQL
    print("[SQL] Generating master SQL file...")
    sql_content, total_sql_rows, total_npcs = generate_sql(zones, all_npcs)
    with open(SQL_OUTPUT, "w", encoding="utf-8") as f:
        f.write(sql_content)
    print(f"[SQL] Written to: {SQL_OUTPUT}")
    print(f"[SQL] Total SQL rows: {total_sql_rows}")
    print()

    # Generate Lua files
    print("[LUA] Generating Lua scripts...")
    lua_files_written = 0
    lua_files_skipped = 0

    for zone_idx, zone in enumerate(zones):
        sn = zone["short_name"]
        npcs = all_npcs.get(sn, [])
        portal_npc_id = PORTAL_NPC_ID_BASE + zone_idx

        if len(npcs) == 0:
            warnings.append(f"  WARNING: {sn} — skipping Lua generation (no NPCs)")
            continue

        zone_quest_dir = os.path.join(QUEST_BASE, sn)
        encounters_dir = os.path.join(zone_quest_dir, "encounters")

        # Create directories
        os.makedirs(zone_quest_dir, exist_ok=True)
        os.makedirs(encounters_dir, exist_ok=True)

        # 1. Portal NPC script
        portal_lua = generate_portal_lua(zone)
        portal_path = os.path.join(zone_quest_dir, f"{portal_npc_id}.lua")
        with open(portal_path, "w", encoding="utf-8") as f:
            f.write(portal_lua)
        lua_files_written += 1

        # 2. Encounter script (boss = first NPC, already sorted by level DESC, hp DESC)
        boss_npc = npcs[0]
        encounter_lua = generate_encounter_lua(zone, boss_npc)
        encounter_path = os.path.join(encounters_dir, "instance_boss.lua")
        with open(encounter_path, "w", encoding="utf-8") as f:
            f.write(encounter_lua)
        lua_files_written += 1

        # 3. script_init.lua
        script_init_content, status = generate_script_init(zone, QUEST_BASE)
        script_init_path = os.path.join(zone_quest_dir, "script_init.lua")
        if script_init_content is not None:
            with open(script_init_path, "w", encoding="utf-8") as f:
                f.write(script_init_content)
            lua_files_written += 1
        else:
            lua_files_skipped += 1

        # Print per-zone summary
        boss_display = boss_npc["name"].replace("#", " ").replace("_", " ")
        print(f"  [{sn:20s}] NPCs: {len(npcs):3d} | Boss: {boss_display:35s} (ID {boss_npc['id']}) | script_init: {status}")

    print()
    print("=" * 70)
    print("  SUMMARY")
    print("=" * 70)
    print(f"  Zones processed:        {len(zones)}")
    print(f"  Total named NPCs:       {total_npcs}")
    print(f"  Total SQL rows:          {total_sql_rows}")
    print(f"  Lua files written:       {lua_files_written}")
    print(f"  Lua files skipped:       {lua_files_skipped}")
    print()

    if warnings:
        print("  WARNINGS:")
        for w in warnings:
            print(f"    {w}")
        print()

    # Print ID ranges used
    print(f"  Portal NPC IDs:          {PORTAL_NPC_ID_BASE} - {PORTAL_NPC_ID_BASE + len(zones) - 1}")
    print(f"  Named spawngroup IDs:    {NAMED_SG_BASE} - {NAMED_SG_BASE + total_npcs - 1}")
    print(f"  Named spawn2 IDs:        {NAMED_S2_BASE} - {NAMED_S2_BASE + total_npcs - 1}")
    print(f"  Portal spawngroup IDs:   {PORTAL_SG_BASE} - {PORTAL_SG_BASE + len(zones) - 1}")
    print(f"  Portal spawn2 IDs:       {PORTAL_S2_BASE} - {PORTAL_S2_BASE + len(zones) - 1}")
    print()
    print("  Done! Run the SQL file to apply changes.")
    print("=" * 70)


if __name__ == "__main__":
    main()

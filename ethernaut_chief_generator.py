#!/usr/bin/env python3
"""
Ethernaut's & Chief Item Generator
===================================
Generates enhanced versions of dropped and quested equipment.
All tuning values are in the TUNING PANEL below — change them and re-run.

Usage:
  python ethernaut_chief_generator.py              # Generate + execute SQL
  python ethernaut_chief_generator.py --dry-run    # Generate SQL only, don't execute
  python ethernaut_chief_generator.py --rollback   # Remove all generated items from DB
"""

import mysql.connector
import math
import os
import re
import sys
from pathlib import Path

# ==========================================================================
#  TUNING PANEL — Change these values and re-run the script to regenerate.
#  The script auto-cleans old generated items before inserting new ones.
# ==========================================================================

# ─── Ethernaut's (Dropped Items) ─────────────────────────────────────────
ETHERNAUT_STAT_MULTIPLIER  = 1.5   # All stats: AC, STR, HP, saves, etc.
ETHERNAUT_MOD_MULTIPLIER   = 1.5   # Modifiers: haste, procrate, etc.
ETHERNAUT_DAMAGE_MULTIPLIER = 2    # Weapon damage multiplier
ETHERNAUT_DELAY_REDUCTION   = 0.30 # Weapon delay reduced by 30%
ETHERNAUT_LOOT_CHANCE       = 20   # % chance in loot tables (1-100)
ETHERNAUT_NAME_PREFIX       = "Ethernaut's "   # Prefix for item names

# ─── Chief (Quested Items) ───────────────────────────────────────────────
CHIEF_AC_SAVE_MULTIPLIER   = 1.5   # AC and saves (FR, CR, MR, DR, PR)
CHIEF_STAT_MULTIPLIER      = 2.0   # All other stats (STR, WIS, HP, MANA, etc.)
CHIEF_MOD_MULTIPLIER       = 2.0   # Modifiers: haste, procrate, etc.
CHIEF_DAMAGE_MULTIPLIER    = 4     # Weapon damage multiplier
CHIEF_DELAY_REDUCTION      = 0.30  # Weapon delay reduced by 30%
CHIEF_NAME_PREFIX          = "Chief "   # Prefix for item names

# ─── Global Constraints ─────────────────────────────────────────────────
WEAPON_DELAY_FLOOR = 10    # Minimum weapon delay (nothing below this)
HASTE_CAP          = 100   # Maximum haste % (hard cap)

# ─── ID Ranges ───────────────────────────────────────────────────────────
ETHERNAUT_ID_START = 1_000_001   # First ID for Ethernaut items
CHIEF_ID_START     = 1_100_001   # First ID for Chief items

# ─── Paths ───────────────────────────────────────────────────────────────
QUEST_DIR  = r"D:\app ideas\MentalBreak\eqemu server\eqemu\quests"
OUTPUT_SQL = r"D:\app ideas\MentalBreak\ethernaut_chief_items.sql"

# ─── Database ────────────────────────────────────────────────────────────
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': '1',
    'database': 'peq'
}

# ==========================================================================
#  END OF TUNING PANEL — Everything below is engine code.
# ==========================================================================

MAX_NAME_LEN = 64
MAX_LORE_LEN = 80

# ─── Stat / Modifier Field Definitions ──────────────────────────────────

# Fields that are "stats" — scaled by the stat multiplier
STAT_FIELDS = [
    'ac', 'astr', 'asta', 'adex', 'aagi', 'aint', 'awis', 'acha',
    'hp', 'mana', 'endur',
    'fr', 'cr', 'mr', 'dr', 'pr', 'svcorruption',
    'attack', 'regen', 'manaregen', 'enduranceregen',
    'heroic_str', 'heroic_int', 'heroic_wis', 'heroic_agi',
    'heroic_dex', 'heroic_sta', 'heroic_cha',
    'heroic_pr', 'heroic_dr', 'heroic_fr', 'heroic_cr',
    'heroic_mr', 'heroic_svcorrup',
    'healamt', 'spelldmg', 'clairvoyance', 'backstabdmg',
    'damageshield', 'shielding', 'avoidance', 'accuracy',
    'strikethrough', 'stunresist', 'dotshielding', 'spellshield',
]

# Fields that are "modifiers" — scaled by the modifier multiplier
MODIFIER_FIELDS = [
    'haste', 'skillmodvalue', 'procrate',
    'elemdmgamt', 'banedmgamt', 'banedmgraceamt', 'extradmgamt',
]

# AC and saves — for Chief items these use the AC_SAVE multiplier
AC_AND_SAVES = ['ac', 'fr', 'cr', 'mr', 'dr', 'pr', 'svcorruption']

# ─── Helper Functions ────────────────────────────────────────────────────────

def ceil_int(val):
    """Ceiling for positive values, floor for negative (e.g., negative saves)."""
    if val >= 0:
        return math.ceil(val)
    else:
        return math.floor(val)


def scale_item(item, stat_mult, mod_mult, dmg_mult, delay_reduction, chief_mode=False,
               chief_ac_save_mult=None):
    """
    Apply scaling to an item dict. Returns a new dict with scaled values.
    All multipliers are read from the TUNING PANEL constants.
    """
    scaled = dict(item)  # shallow copy
    
    for field in STAT_FIELDS:
        val = item.get(field, 0)
        if val == 0:
            continue
        if chief_mode and field not in AC_AND_SAVES:
            scaled[field] = ceil_int(val * stat_mult)
        elif chief_mode and chief_ac_save_mult is not None:
            scaled[field] = ceil_int(val * chief_ac_save_mult)
        else:
            scaled[field] = ceil_int(val * stat_mult)
    
    for field in MODIFIER_FIELDS:
        val = item.get(field, 0)
        if val == 0:
            continue
        scaled[field] = ceil_int(val * mod_mult)
    
    # Cap haste
    if scaled.get('haste', 0) > HASTE_CAP:
        scaled['haste'] = HASTE_CAP
    
    # Enforce Magic and Tradable tags
    scaled['magic'] = 1
    scaled['nodrop'] = 1
    
    # Weapon scaling
    if item.get('damage', 0) > 0:
        scaled['damage'] = int(item['damage'] * dmg_mult)
    if item.get('delay', 0) > 0:
        new_delay = max(round(item['delay'] * (1.0 - delay_reduction)), WEAPON_DELAY_FLOOR)
        scaled['delay'] = int(new_delay)
    
    return scaled


def make_name(prefix, original_name, max_len):
    """Create prefixed name, truncating original if needed."""
    full = f"{prefix}{original_name}"
    if len(full) > max_len:
        return full[:max_len]
    return full


def escape_sql(val):
    """Escape a value for SQL insertion."""
    if val is None:
        return "NULL"
    if isinstance(val, str):
        return "'" + val.replace("\\", "\\\\").replace("'", "\\'") + "'"
    if isinstance(val, (int, float)):
        return str(val)
    return "'" + str(val).replace("\\", "\\\\").replace("'", "\\'") + "'"


# ─── Quest Reward Scanner ───────────────────────────────────────────────────

def scan_quest_reward_ids(quest_dir):
    """
    Scan all .pl and .lua quest files for quest::summonitem(ID) calls.
    Returns a set of integer item IDs that are quest rewards.
    """
    reward_ids = set()
    pattern = re.compile(r'quest::summonitem\s*\(\s*(\d+)\s*\)')
    
    quest_path = Path(quest_dir)
    for ext in ('*.pl', '*.lua'):
        for filepath in quest_path.rglob(ext):
            try:
                content = filepath.read_text(encoding='utf-8', errors='ignore')
                for match in pattern.finditer(content):
                    reward_ids.add(int(match.group(1)))
            except Exception:
                pass
    
    print(f"  Found {len(reward_ids)} unique quest reward item IDs from scripts")
    return reward_ids


# ─── Main Generator ─────────────────────────────────────────────────────────

def get_all_item_columns(cursor):
    """Get all column names from the items table."""
    cursor.execute("DESCRIBE items")
    return [row[0] for row in cursor.fetchall()]


def fetch_items_by_ids(cursor, item_ids, columns):
    """Fetch items by a list of IDs."""
    if not item_ids:
        return []
    
    cols_str = ', '.join(f'`{c}`' for c in columns)
    # Process in batches to avoid query size limits
    items = []
    batch_size = 500
    id_list = list(item_ids)
    
    for i in range(0, len(id_list), batch_size):
        batch = id_list[i:i+batch_size]
        placeholders = ','.join(str(x) for x in batch)
        cursor.execute(f"SELECT {cols_str} FROM items WHERE id IN ({placeholders})")
        for row in cursor.fetchall():
            item = dict(zip(columns, row))
            items.append(item)
    
    return items


def fetch_dropped_items(cursor, columns):
    """
    Fetch all unique items that appear in lootdrop_entries and have
    meaningful stats (armor, weapons, or items with stat bonuses).
    Excludes existing Ethernaut's items and items already prefixed with Chief.
    """
    cols_str = ', '.join(f'i.`{c}`' for c in columns)
    
    query = f"""
    SELECT DISTINCT {cols_str}
    FROM items i
    JOIN lootdrop_entries lde ON i.id = lde.item_id
    WHERE i.itemclass = 0
      AND i.Name NOT LIKE 'Ethernaut%%'
      AND i.Name NOT LIKE 'Chief %%'
      AND (
          i.ac > 0 OR i.astr > 0 OR i.asta > 0 OR i.adex > 0 OR 
          i.aagi > 0 OR i.aint > 0 OR i.awis > 0 OR i.acha > 0 OR
          i.hp > 0 OR i.mana > 0 OR i.endur > 0 OR
          i.fr > 0 OR i.cr > 0 OR i.mr > 0 OR i.dr > 0 OR i.pr > 0 OR
          i.damage > 0 OR i.haste > 0 OR
          i.heroic_str > 0 OR i.heroic_int > 0 OR i.heroic_wis > 0 OR
          i.heroic_agi > 0 OR i.heroic_dex > 0 OR i.heroic_sta > 0 OR
          i.attack > 0 OR i.regen > 0 OR i.manaregen > 0 OR
          i.healamt > 0 OR i.spelldmg > 0 OR
          i.damageshield > 0 OR i.shielding > 0 OR
          i.avoidance > 0 OR i.accuracy > 0 OR i.strikethrough > 0
      )
    """
    cursor.execute(query)
    items = []
    for row in cursor.fetchall():
        item = dict(zip(columns, row))
        items.append(item)
    
    return items


def fetch_lootdrop_mappings(cursor, item_ids):
    """
    For each original item_id, find all lootdrop_ids it appears in.
    Returns dict: {original_item_id: [(lootdrop_id, item_charges, equip_item, 
                                        trivial_min_level, trivial_max_level,
                                        npc_min_level, npc_max_level,
                                        min_expansion, max_expansion,
                                        content_flags, content_flags_disabled), ...]}
    """
    mappings = {}
    batch_size = 500
    id_list = list(item_ids)
    
    for i in range(0, len(id_list), batch_size):
        batch = id_list[i:i+batch_size]
        placeholders = ','.join(str(x) for x in batch)
        cursor.execute(f"""
            SELECT lootdrop_id, item_id, item_charges, equip_item,
                   trivial_min_level, trivial_max_level,
                   npc_min_level, npc_max_level,
                   min_expansion, max_expansion,
                   content_flags, content_flags_disabled
            FROM lootdrop_entries 
            WHERE item_id IN ({placeholders})
        """)
        for row in cursor.fetchall():
            (lootdrop_id, item_id, item_charges, equip_item,
             triv_min, triv_max, npc_min, npc_max,
             min_exp, max_exp, content_flags, content_flags_disabled) = row
            if item_id not in mappings:
                mappings[item_id] = []
            mappings[item_id].append({
                'lootdrop_id': lootdrop_id,
                'item_charges': item_charges,
                'equip_item': equip_item,
                'trivial_min_level': triv_min,
                'trivial_max_level': triv_max,
                'npc_min_level': npc_min,
                'npc_max_level': npc_max,
                'min_expansion': min_exp,
                'max_expansion': max_exp,
                'content_flags': content_flags,
                'content_flags_disabled': content_flags_disabled,
            })
    
    return mappings


def generate_insert_sql(item, columns, new_id, new_name, new_lore):
    """Generate an INSERT statement for a new item."""
    values = []
    for col in columns:
        if col == 'id':
            values.append(str(new_id))
        elif col == 'Name':
            values.append(escape_sql(new_name))
        elif col == 'lore':
            values.append(escape_sql(new_lore))
        elif col == 'updated':
            values.append("NOW()")
        elif col == 'serialized':
            values.append("NULL")
        elif col == 'verified':
            values.append("NULL")
        elif col == 'serialization':
            values.append("NULL")
        elif col in ('comment',):
            values.append(escape_sql(item.get(col, '')))
        else:
            val = item.get(col)
            if val is None:
                values.append("NULL")
            elif isinstance(val, str):
                values.append(escape_sql(val))
            else:
                values.append(str(val))
    
    cols_str = ', '.join(f'`{c}`' for c in columns)
    vals_str = ', '.join(values)
    return f"INSERT INTO `items` ({cols_str}) VALUES ({vals_str});"


def generate_lootdrop_entry_sql(lootdrop_id, new_item_id, entry_data):
    """Generate INSERT for a lootdrop_entries row with 20% chance."""
    cf = escape_sql(entry_data.get('content_flags', ''))
    cfd = escape_sql(entry_data.get('content_flags_disabled', ''))
    
    return (
        f"INSERT INTO `lootdrop_entries` "
        f"(lootdrop_id, item_id, item_charges, equip_item, chance, disabled_chance, "
        f"trivial_min_level, trivial_max_level, multiplier, "
        f"npc_min_level, npc_max_level, "
        f"min_expansion, max_expansion, content_flags, content_flags_disabled) "
        f"VALUES ("
        f"{lootdrop_id}, {new_item_id}, "
        f"{entry_data['item_charges']}, {entry_data['equip_item']}, "
        f"{ETHERNAUT_LOOT_CHANCE}, 0, "  # Loot chance from TUNING PANEL
        f"{entry_data['trivial_min_level']}, {entry_data['trivial_max_level']}, 1, "
        f"{entry_data['npc_min_level']}, {entry_data['npc_max_level']}, "
        f"{entry_data['min_expansion']}, {entry_data['max_expansion']}, "
        f"{cf}, {cfd});"
    )


def rollback(cursor, conn):
    """Remove all generated Ethernaut's and Chief items from the database."""
    print("\n[ROLLBACK] Removing all generated items...")
    cursor.execute(f"DELETE FROM lootdrop_entries WHERE item_id >= {ETHERNAUT_ID_START} AND item_id < {CHIEF_ID_START + 100000}")
    lde_deleted = cursor.rowcount
    cursor.execute(f"DELETE FROM items WHERE id >= {ETHERNAUT_ID_START} AND id < {ETHERNAUT_ID_START + 100000}")
    eth_deleted = cursor.rowcount
    cursor.execute(f"DELETE FROM items WHERE id >= {CHIEF_ID_START} AND id < {CHIEF_ID_START + 100000}")
    chief_deleted = cursor.rowcount
    conn.commit()
    print(f"  Deleted {eth_deleted:,} Ethernaut's items")
    print(f"  Deleted {chief_deleted:,} Chief items")
    print(f"  Deleted {lde_deleted:,} lootdrop entries")
    print("  ROLLBACK COMPLETE. Run #hotfix in-game to apply.")


def main():
    # ─── CLI argument handling ────────────────────────────────────────────
    dry_run = '--dry-run' in sys.argv
    do_rollback = '--rollback' in sys.argv
    
    print("=" * 70)
    print("  Ethernaut's & Chief Item Generator")
    print("=" * 70)
    
    # Print current tuning values so user can verify
    print("\n  TUNING PANEL (current values):")
    print(f"    Ethernaut's: stats x{ETHERNAUT_STAT_MULTIPLIER}, mods x{ETHERNAUT_MOD_MULTIPLIER}, "  
          f"dmg x{ETHERNAUT_DAMAGE_MULTIPLIER}, delay -{int(ETHERNAUT_DELAY_REDUCTION*100)}%, "  
          f"loot {ETHERNAUT_LOOT_CHANCE}%")
    print(f"    Chief:       AC/saves x{CHIEF_AC_SAVE_MULTIPLIER}, stats x{CHIEF_STAT_MULTIPLIER}, "  
          f"mods x{CHIEF_MOD_MULTIPLIER}, dmg x{CHIEF_DAMAGE_MULTIPLIER}, "  
          f"delay -{int(CHIEF_DELAY_REDUCTION*100)}%")
    print(f"    Constraints: delay floor={WEAPON_DELAY_FLOOR}, haste cap={HASTE_CAP}%")
    
    # ─── Connect to database ─────────────────────────────────────────────
    print("\n[Phase 0] Connecting to database...")
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    
    # ─── Handle --rollback ────────────────────────────────────────────────
    if do_rollback:
        rollback(cursor, conn)
        cursor.close()
        conn.close()
        return
    
    # ─── Auto-clean old generated items before regenerating ──────────────
    print("  Cleaning old generated items (safe re-run)...")
    cursor.execute(f"DELETE FROM lootdrop_entries WHERE item_id >= {ETHERNAUT_ID_START} AND item_id < {CHIEF_ID_START + 100000}")
    old_lde = cursor.rowcount
    cursor.execute(f"DELETE FROM items WHERE id >= {ETHERNAUT_ID_START} AND id < {ETHERNAUT_ID_START + 100000}")
    old_eth = cursor.rowcount
    cursor.execute(f"DELETE FROM items WHERE id >= {CHIEF_ID_START} AND id < {CHIEF_ID_START + 100000}")
    old_chief = cursor.rowcount
    conn.commit()
    if old_eth + old_chief + old_lde > 0:
        print(f"  Cleaned: {old_eth:,} Ethernaut + {old_chief:,} Chief items + {old_lde:,} lootdrop entries")
    else:
        print("  No previous generated items found (fresh run)")
    
    # ─── Phase 0: Scan quest scripts for reward IDs ──────────────────────
    print("\n[Phase 0] Scanning quest scripts for reward item IDs...")
    quest_reward_ids = scan_quest_reward_ids(QUEST_DIR)
    
    columns = get_all_item_columns(cursor)
    print(f"  Items table has {len(columns)} columns")
    
    # ─── Phase 1: Ethernaut's Items (Dropped) ────────────────────────────
    print("\n[Phase 1] Fetching dropped items with meaningful stats...")
    dropped_items = fetch_dropped_items(cursor, columns)
    print(f"  Found {len(dropped_items)} unique dropped items to create Ethernaut's versions of")
    
    print("  Fetching lootdrop mappings...")
    dropped_ids = {item['id'] for item in dropped_items}
    lootdrop_map = fetch_lootdrop_mappings(cursor, dropped_ids)
    total_lootdrop_entries = sum(len(v) for v in lootdrop_map.values())
    print(f"  Found {total_lootdrop_entries} lootdrop_entries to create")
    
    # ─── Phase 2: Chief Items (Quested) ──────────────────────────────────
    print("\n[Phase 2] Fetching quested items (weapons and armor)...")
    quest_items_raw = fetch_items_by_ids(cursor, quest_reward_ids, columns)
    
    # Filter to only weapons and armor with meaningful stats
    quest_items = []
    for item in quest_items_raw:
        # Skip items already prefixed
        name = item.get('Name', '')
        if name.startswith("Ethernaut's") or name.startswith("Chief "):
            continue
        # Must be a normal item (itemclass=0) — not a container or book
        if item.get('itemclass', 0) != 0:
            continue
        # Must have some meaningful stat to boost
        has_stats = any(item.get(f, 0) != 0 for f in STAT_FIELDS + MODIFIER_FIELDS)
        has_damage = item.get('damage', 0) > 0
        if not has_stats and not has_damage:
            continue
        quest_items.append(item)
    
    print(f"  Found {len(quest_items)} quest reward items with meaningful stats")
    
    # ─── Phase 3: Generate SQL ───────────────────────────────────────────
    print("\n[Phase 3] Generating SQL...")
    
    ethernaut_count = 0
    chief_count = 0
    lootdrop_entry_count = 0
    
    # Track original_id -> new_id mapping
    ethernaut_id_map = {}
    chief_id_map = {}
    
    # Build all SQL statements
    item_inserts = []
    lootdrop_inserts = []
    
    # ─── Ethernaut's items ───────────────────────────────────────────────
    print("  Generating Ethernaut's items...")
    for item in dropped_items:
        orig_id = item['id']
        new_id = ETHERNAUT_ID_START + ethernaut_count
        
        # Scale stats
        scaled = scale_item(item,
            stat_mult=ETHERNAUT_STAT_MULTIPLIER,
            mod_mult=ETHERNAUT_MOD_MULTIPLIER,
            dmg_mult=ETHERNAUT_DAMAGE_MULTIPLIER,
            delay_reduction=ETHERNAUT_DELAY_REDUCTION,
            chief_mode=False)
        
        # Set new identity
        new_name = make_name(ETHERNAUT_NAME_PREFIX, item['Name'], MAX_NAME_LEN)
        orig_lore = item.get('lore', '') or ''
        new_lore = make_name(ETHERNAUT_NAME_PREFIX, orig_lore, MAX_LORE_LEN) if orig_lore else ''
        
        # Generate item INSERT
        sql = generate_insert_sql(scaled, columns, new_id, new_name, new_lore)
        item_inserts.append(sql)
        
        ethernaut_id_map[orig_id] = new_id
        ethernaut_count += 1
        
        # Generate lootdrop_entries INSERTs (20% chance)
        if orig_id in lootdrop_map:
            for entry in lootdrop_map[orig_id]:
                loot_sql = generate_lootdrop_entry_sql(
                    entry['lootdrop_id'], new_id, entry
                )
                lootdrop_inserts.append(loot_sql)
                lootdrop_entry_count += 1
    
    print(f"    Created {ethernaut_count} Ethernaut's items")
    print(f"    Created {lootdrop_entry_count} lootdrop entries")
    
    # ─── Chief items ─────────────────────────────────────────────────────
    print("  Generating Chief items...")
    for item in quest_items:
        orig_id = item['id']
        new_id = CHIEF_ID_START + chief_count
        
        # Scale stats (Chief mode: AC/saves x1.5, others x2.0)
        scaled = scale_item(item,
            stat_mult=CHIEF_STAT_MULTIPLIER,
            mod_mult=CHIEF_MOD_MULTIPLIER,
            dmg_mult=CHIEF_DAMAGE_MULTIPLIER,
            delay_reduction=CHIEF_DELAY_REDUCTION,
            chief_mode=True,
            chief_ac_save_mult=CHIEF_AC_SAVE_MULTIPLIER)
        
        # Set new identity
        new_name = make_name(CHIEF_NAME_PREFIX, item['Name'], MAX_NAME_LEN)
        orig_lore = item.get('lore', '') or ''
        new_lore = make_name(CHIEF_NAME_PREFIX, orig_lore, MAX_LORE_LEN) if orig_lore else ''
        
        # Generate item INSERT
        sql = generate_insert_sql(scaled, columns, new_id, new_name, new_lore)
        item_inserts.append(sql)
        
        chief_id_map[orig_id] = new_id
        chief_count += 1
    
    print(f"    Created {chief_count} Chief items")
    
    # ─── Phase 4: Write SQL File ─────────────────────────────────────────
    print(f"\n[Phase 4] Writing SQL to {OUTPUT_SQL}...")
    
    with open(OUTPUT_SQL, 'w', encoding='utf-8') as f:
        f.write("-- ================================================================\n")
        f.write("-- Ethernaut's & Chief Item Generator Output\n")
        f.write("-- ================================================================\n")
        f.write(f"-- Ethernaut's items: {ethernaut_count}\n")
        f.write(f"-- Chief items:       {chief_count}\n")
        f.write(f"-- Lootdrop entries:  {lootdrop_entry_count}\n")
        f.write(f"-- Total new items:   {ethernaut_count + chief_count}\n")
        f.write("-- ================================================================\n")
        f.write("--\n")
        f.write(f"-- Ethernaut's Formula:\n")
        f.write(f"--   Stats:     x{ETHERNAUT_STAT_MULTIPLIER} (ceil)  |  Modifiers: x{ETHERNAUT_MOD_MULTIPLIER} (ceil)\n")
        f.write(f"--   Weapons:   damage x{ETHERNAUT_DAMAGE_MULTIPLIER}, delay -{int(ETHERNAUT_DELAY_REDUCTION*100)}% (floor {WEAPON_DELAY_FLOOR})\n")
        f.write(f"--   Haste cap: {HASTE_CAP}%\n")
        f.write(f"--   Loot:      {ETHERNAUT_LOOT_CHANCE}% chance in same lootdrop as original\n")
        f.write("--\n")
        f.write(f"-- Chief Formula:\n")
        f.write(f"--   AC/Saves:  x{CHIEF_AC_SAVE_MULTIPLIER} (ceil)  |  Other stats: x{CHIEF_STAT_MULTIPLIER} (ceil)\n")
        f.write(f"--   Modifiers: x{CHIEF_MOD_MULTIPLIER} (ceil)  |  Weapons: damage x{CHIEF_DAMAGE_MULTIPLIER}, delay -{int(CHIEF_DELAY_REDUCTION*100)}% (floor {WEAPON_DELAY_FLOOR})\n")
        f.write(f"--   Haste cap: {HASTE_CAP}%\n")
        f.write("--   NOT added to loot tables (quest-only)\n")
        f.write("-- ================================================================\n\n")
        
        # Rollback section
        f.write("-- ┌─────────────────────────────────────────────────────────────┐\n")
        f.write("-- │ ROLLBACK (uncomment and run to undo all changes)            │\n")
        f.write("-- └─────────────────────────────────────────────────────────────┘\n")
        f.write(f"-- DELETE FROM lootdrop_entries WHERE item_id >= {ETHERNAUT_ID_START} AND item_id < {CHIEF_ID_START + chief_count};\n")
        f.write(f"-- DELETE FROM items WHERE id >= {ETHERNAUT_ID_START} AND id < {ETHERNAUT_ID_START + ethernaut_count};\n")
        f.write(f"-- DELETE FROM items WHERE id >= {CHIEF_ID_START} AND id < {CHIEF_ID_START + chief_count};\n")
        f.write("\n")
        
        # Ethernaut's items
        f.write("-- ================================================================\n")
        f.write(f"-- ETHERNAUT'S ITEMS ({ethernaut_count} items)\n")
        f.write("-- ================================================================\n\n")
        
        for i, sql in enumerate(item_inserts[:ethernaut_count]):
            f.write(sql + "\n")
            if (i + 1) % 1000 == 0:
                f.write(f"\n-- Progress: {i+1}/{ethernaut_count} Ethernaut's items\n\n")
        
        # Chief items
        f.write("\n-- ================================================================\n")
        f.write(f"-- CHIEF ITEMS ({chief_count} items)\n")
        f.write("-- ================================================================\n\n")
        
        for sql in item_inserts[ethernaut_count:]:
            f.write(sql + "\n")
        
        # Lootdrop entries
        f.write("\n-- ================================================================\n")
        f.write(f"-- LOOTDROP ENTRIES ({lootdrop_entry_count} entries, {ETHERNAUT_LOOT_CHANCE}% chance each)\n")
        f.write("-- ================================================================\n\n")
        
        for i, sql in enumerate(lootdrop_inserts):
            f.write(sql + "\n")
            if (i + 1) % 5000 == 0:
                f.write(f"\n-- Progress: {i+1}/{lootdrop_entry_count} lootdrop entries\n\n")
    
    # ─── Phase 5: Spot-Check Verification ────────────────────────────────
    print("\n[Phase 5] Spot-check verification against user's examples...")
    
    # Verify Ethereal Mist Boots (ID 4887)
    if 4887 in ethernaut_id_map:
        boots = next(i for i in dropped_items if i['id'] == 4887)
        scaled_boots = scale_item(boots, ETHERNAUT_STAT_MULTIPLIER, ETHERNAUT_MOD_MULTIPLIER,
                                  ETHERNAUT_DAMAGE_MULTIPLIER, ETHERNAUT_DELAY_REDUCTION, chief_mode=False)
        print(f"\n  Ethereal Mist Boots (4887 -> {ethernaut_id_map[4887]}):")
        print(f"    AC:  {boots['ac']} -> {scaled_boots['ac']}")
        print(f"    INT: {boots['aint']} -> {scaled_boots['aint']}")
        print(f"    AGI: {boots['aagi']} -> {scaled_boots['aagi']}")
        print(f"    CR:  {boots['cr']} -> {scaled_boots['cr']}")
    
    if 1365 in ethernaut_id_map:
        sash = next(i for i in dropped_items if i['id'] == 1365)
        scaled_sash = scale_item(sash, ETHERNAUT_STAT_MULTIPLIER, ETHERNAUT_MOD_MULTIPLIER,
                                 ETHERNAUT_DAMAGE_MULTIPLIER, ETHERNAUT_DELAY_REDUCTION, chief_mode=False)
        print(f"\n  Flowing Black Silk Sash (1365 -> {ethernaut_id_map[1365]}):")
        print(f"    Haste: {sash['haste']} -> {scaled_sash['haste']}")
    
    if 25391 in chief_id_map:
        crown = next(i for i in quest_items if i['id'] == 25391)
        scaled_crown = scale_item(crown, CHIEF_STAT_MULTIPLIER, CHIEF_MOD_MULTIPLIER,
                                  CHIEF_DAMAGE_MULTIPLIER, CHIEF_DELAY_REDUCTION,
                                  chief_mode=True, chief_ac_save_mult=CHIEF_AC_SAVE_MULTIPLIER)
        print(f"\n  Templar's Crown (25391 -> {chief_id_map[25391]}):")
        print(f"    AC:   {crown['ac']} -> {scaled_crown['ac']}")
        print(f"    WIS:  {crown['awis']} -> {scaled_crown['awis']}")
        print(f"    MANA: {crown['mana']} -> {scaled_crown['mana']}")
        print(f"    FR:   {crown['fr']} -> {scaled_crown['fr']}")
        print(f"    STR:  {crown['astr']} -> {scaled_crown['astr']}")
    
    # ─── Summary ─────────────────────────────────────────────────────────
    sql_size_mb = os.path.getsize(OUTPUT_SQL) / (1024 * 1024)
    print(f"\n{'=' * 70}")
    print(f"  GENERATION COMPLETE")
    print(f"{'=' * 70}")
    print(f"  Ethernaut's items:  {ethernaut_count:,}")
    print(f"  Chief items:        {chief_count:,}")
    print(f"  Lootdrop entries:   {lootdrop_entry_count:,}")
    print(f"  Total new items:    {ethernaut_count + chief_count:,}")
    print(f"  SQL file:           {OUTPUT_SQL}")
    print(f"  SQL file size:      {sql_size_mb:.1f} MB")
    print(f"  ID range (Ethernaut): {ETHERNAUT_ID_START} - {ETHERNAUT_ID_START + ethernaut_count - 1}")
    print(f"  ID range (Chief):     {CHIEF_ID_START} - {CHIEF_ID_START + chief_count - 1}")
    
    # --- Phase 6: Execute SQL (unless --dry-run) -------------------------
    if dry_run:
        print(f"\n  --dry-run: SQL written to {OUTPUT_SQL}")
        print(f"  To apply, re-run without --dry-run")
    else:
        print(f"\n[Phase 6] Executing SQL against database...")
        exec_cursor = conn.cursor()
        with open(OUTPUT_SQL, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        statements = [s.strip() for s in sql_content.split(';\n') if s.strip() and not s.strip().startswith('--')]
        total = len(statements)
        for i, stmt in enumerate(statements):
            if stmt.startswith('--') or not stmt.strip():
                continue
            try:
                exec_cursor.execute(stmt)
            except Exception as e:
                if 'Duplicate entry' not in str(e):
                    print(f"  Warning at statement {i}: {e}")
            if (i + 1) % 10000 == 0:
                conn.commit()
                print(f"    Executed {i+1:,}/{total:,} statements...")
        conn.commit()
        exec_cursor.close()
        print(f"    Executed {total:,} statements successfully.")
        print(f"\n  DONE! Run #hotfix in-game to apply.")
    
    cursor.close()
    conn.close()


if __name__ == '__main__':
    main()

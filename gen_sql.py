
import json

with open('research_results.json', 'r') as f:
    data = json.load(f)

# Hardcoded coordinates and spacing
base_x = -162.42
base_y = 49.64
base_z = -158.50
heading = 0
spacing = 5.0 # Spacing between vendors

# Database IDs
next_npc_id = 202901
next_merchant_id = 202901
next_spawngroup_id = 202901
zone_id = 202 # poknowledge
zone_name = "poknowledge"

sql_lines = []

classes = [
    "Bard", "Beastlord", "Cleric", "Druid", "Enchanter",
    "Magician", "Monk", "Necromancer", "Paladin", "Ranger",
    "Rogue", "Shadow Knight", "Shaman", "Warrior", "Wizard"
]

for i, cls in enumerate(classes):
    npc_id = next_npc_id + i
    merchant_id = next_merchant_id + i
    spawngroup_id = next_spawngroup_id + i
    
    npc_name = f"{cls}_Elemental_Armor"
    display_name = f"{cls} Elemental Armor"
    
    # Position
    y = base_y + (i * spacing)
    
    # NPC Type
    sql_lines.append(f"INSERT INTO npc_types (id, name, lastname, level, race, class, bodytype, hp, mana, gender, texture, helmtexture, size, merchant_id) VALUES ({npc_id}, '{npc_name}', '{display_name}', 1, 1, 41, 1, 100, 0, 2, 0, 0, 5, {merchant_id});")
    
    # Merchant List
    items_raw = data['items'][cls].strip().split('\n')[1:]
    slot = 1
    for item_line in items_raw:
        item_id, item_name = item_line.split('\t')
        # Skip weird items or quest items if needed, but the user asked for "PoP Elemental Armor"
        # We'll filter for core armor keywords: Helm, Chestplate, Armplates, Bracer, Gauntlets, Greaves, Boots, etc.
        keywords = ["Helm", "Chestplate", "Armplates", "Bracer", "Gauntlets", "Greaves", "Boots", 
                    "Cap", "Chestwaps", "Gloves", "Leggings", "Sleeves", "Tunic", "Circlet", 
                    "Pantaloons", "Robe", "Slippers", "Bangle", "Shoes", "Pants", "Tiara", 
                    "Shroud", "Bracelet", "Crown", "Skullcap", "Guard", "HauberkMail", "Chainmail", "Guard"]
        
        # Actually, let's just include the 7 standard pieces. 
        # For simplicity, I will include items that look like armor.
        is_armor = any(k.lower() in item_name.lower() for k in keywords)
        
        # Specifically excluding scrolls/spells/songs/tomes
        if "Song:" in item_name or "Spell:" in item_name or "Tome" in item_name or "Scroll:" in item_name:
            continue

        if is_armor:
            sql_lines.append(f"INSERT INTO merchantlist (merchantid, slot, item) VALUES ({merchant_id}, {slot}, {item_id});")
            slot += 1

    # Spawn Group
    sql_lines.append(f"INSERT INTO spawngroup (id, name) VALUES ({spawngroup_id}, '{npc_name}_spawngroup');")
    sql_lines.append(f"INSERT INTO spawnentry (spawngroupID, npcID, chance) VALUES ({spawngroup_id}, {npc_id}, 100);")
    
    # Spawn2
    sql_lines.append(f"INSERT INTO spawn2 (zone, version, spawngroupID, x, y, z, heading, respawntime) VALUES ('{zone_name}', 0, {spawngroup_id}, {base_x}, {y}, {base_z}, {heading}, 30);")

with open('create_vendors.sql', 'w') as f:
    f.write('\n'.join(sql_lines))

print(f"Generated SQL script for {len(classes)} vendors.")

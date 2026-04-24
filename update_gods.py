import os

# Define the vendor to god mappings
# Format: ID: (Race, Gender, Name)
vendors = {
    202901: (498, 1, "Ayonae Ro"),        # Bard
    202902: (295, 2, "Zebuxoruk"),        # Beastlord
    202903: (296, 2, "Mithaniel Marr"),   # Cleric
    202904: (62, 2, "Tunare"),            # Druid
    202905: (283, 2, "Saryrn"),           # Enchanter
    202906: (284, 2, "Fennin Ro"),        # Magician
    202907: (299, 2, "Xegony"),           # Monk
    202908: (255, 2, "Bertoxxulous"),     # Necromancer
    202909: (256, 2, "The Tribunal"),     # Paladin
    202910: (278, 2, "Karana"),           # Ranger
    202911: (153, 2, "Bristlebane"),      # Rogue
    202912: (95, 2, "Cazic Thule"),       # Shadow Knight
    202913: (246, 2, "Coirnav"),          # Shaman
    202914: (288, 2, "Rallos Zek"),       # Warrior
    202915: (247, 2, "Solusek Ro"),       # Wizard
    202916: (304, 2, "Quarm"),            # Epic Vendor
    202917: (289, 2, "Vallon Zek")        # Berserker
}

sql_statements = []
sql_statements.append("-- Transforming Vendors into Miniature Gods")

for vendor_id, (race, gender, name) in vendors.items():
    sql = f"UPDATE npc_types SET race = {race}, gender = {gender}, size = 3, texture = 0, helmtexture = 0 WHERE id = {vendor_id};"
    sql_statements.append(sql)

output_file = "update_gods.sql"
with open(output_file, "w") as f:
    f.write("\n".join(sql_statements) + "\n")

print(f"Generated {output_file}")

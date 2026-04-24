import os

# Vendor IDs: 15 base classes + Berserker
vendor_ids = list(range(202901, 202916)) + [202917]

# Let's assume the pathway runs along the Y axis (since they were lined up along Y previously).
# We'll split the 16 vendors into two groups of 8.
# One group on the left edge, one group on the right edge.
# You can tweak these values if the pathway is wider or narrower.
START_Y = 50.0
SPACING_Y = 10.0
CENTER_X = -162.42
PATHWAY_WIDTH = 20.0 # Total width, so 10 units left and 10 units right

# Headings in EQ are typically 0 to 255 (or 0-512 depending on client, but usually 0-255 in db). 
# 64 is right, 128 is down, 192 is left, 255/0 is up. 
# We'll point them inward towards the center of the path.
HEADING_LEFT_SIDE = 64
HEADING_RIGHT_SIDE = 192
Z_COORD = -158.5

sql_statements = []
sql_statements.append("-- Repositioning 16 Class Armor Vendors to line the edges of the pathway")
sql_statements.append(f"-- Pathway assumed center X: {CENTER_X}, Width: {PATHWAY_WIDTH}")

for i, vendor_id in enumerate(vendor_ids):
    # Determine side: even index on left, odd index on right
    is_left = (i % 2 == 0)
    
    # Calculate Y coordinate (every pair shares the same Y so they face each other)
    pair_index = i // 2
    y_coord = START_Y + (pair_index * SPACING_Y)
    
    if is_left:
        x_coord = CENTER_X - (PATHWAY_WIDTH / 2.0)
        heading = HEADING_LEFT_SIDE
    else:
        x_coord = CENTER_X + (PATHWAY_WIDTH / 2.0)
        heading = HEADING_RIGHT_SIDE
        
    sql = f"UPDATE spawn2 SET x = {x_coord:.2f}, y = {y_coord:.2f}, z = {Z_COORD:.2f}, heading = {heading} WHERE spawngroupID = {vendor_id};"
    sql_statements.append(sql)

output_file = "reposition_vendors.sql"
with open(output_file, "w") as f:
    f.write("\n".join(sql_statements) + "\n")

print(f"Generated {output_file} with update statements.")

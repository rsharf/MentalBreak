import os

# Vendor IDs: 15 base classes + Berserker
vendor_ids = list(range(202901, 202916)) + [202917]

# The critical mistake: EQ /loc outputs Y, X, Z! 
# Original user locs:
# 1) Y=125.47, X=-131.95
# 2) Y=-4.54, X=-128.52
# 3) Y=127.29, X=-243.90

# Let's define the 3 borders of the grass patch.
# Grass boundaries appear to be:
# Y runs from roughly -5 to 125
# X runs from roughly -132 to -244

# EQ Headings: 0 = +Y (North), 64 = +X (West), 128 = -Y (South), 192 = -X (East)
# We want them on the edge of the grass, facing outward toward the paved path.

segments = [
    # Right edge: X ≈ -130, Y from -5 to 125. Facing +X (West) -> 64
    {"start_x": -130, "start_y": -5, "end_x": -130, "end_y": 125, "heading": 64},
    
    # Top edge: Y ≈ 125, X from -130 to -244. Facing +Y (North) -> 0
    {"start_x": -130, "start_y": 125, "end_x": -244, "end_y": 125, "heading": 0},
    
    # Left edge: X ≈ -244, Y from 125 to -5. Facing -X (East) -> 192
    {"start_x": -244, "start_y": 125, "end_x": -244, "end_y": -5, "heading": 192}
]

def dist(s):
    return ((s["start_x"] - s["end_x"])**2 + (s["start_y"] - s["end_y"])**2)**0.5

total_length = sum(dist(s) for s in segments)
num_vendors = len(vendor_ids)
spacing = total_length / (num_vendors - 1)

Z_COORD = -158.50 # Using the exact Epic Vendor Z to prevent floating/falling

sql_statements = []
sql_statements.append("-- Repositioning 16 Class Armor Vendors (Corrected Y, X)")

for i, vendor_id in enumerate(vendor_ids):
    target_distance = i * spacing
    
    # Find segment
    seg_start_dist = 0.0
    seg = segments[0]
    for s in segments:
        seg_len = dist(s)
        if target_distance <= seg_start_dist + seg_len + 0.001:
            seg = s
            break
        seg_start_dist += seg_len
        
    local_dist = target_distance - seg_start_dist
    seg_len = dist(seg)
    ratio = local_dist / seg_len if seg_len > 0 else 0
    
    x = seg["start_x"] + ratio * (seg["end_x"] - seg["start_x"])
    y = seg["start_y"] + ratio * (seg["end_y"] - seg["start_y"])
    heading = seg["heading"]
    
    # Adjust corner headings slightly for smooth visuals
    if abs(ratio - 0.0) < 0.01 and i != 0:
        if heading == 0: # Corner between Right Edge and Top Edge
            heading = 32 # Face North-West
        elif heading == 192: # Corner between Top Edge and Left Edge
            heading = 224 # Face North-East
            
    sql = f"UPDATE spawn2 SET x = {x:.2f}, y = {y:.2f}, z = {Z_COORD:.2f}, heading = {heading} WHERE spawngroupID = {vendor_id};"
    sql_statements.append(sql)

output_file = "reposition_vendors_u_shape_fixed.sql"
with open(output_file, "w") as f:
    f.write("\n".join(sql_statements) + "\n")

print(f"Generated {output_file}")

import os

# Vendor IDs: 15 base classes + Berserker
vendor_ids = list(range(202901, 202916)) + [202917]

# We have 3 borders forming a U-shape based on the provided coordinates:
# P1: (-5, -130)   [Derived from -4.54, -128.52]
# P2: (125, -130)  [Derived from 125.47, -131.95]
# P3: (125, -244)  [Derived from 127.29, -243.90]
# P4: (-5, -244)   [Implied to complete the U-shape]

# We will place them on the edge of the grass facing OUTWARD toward the pathway.
# EQ Headings: 0 = +Y (North), 64 = +X (West), 128 = -Y (South), 192 = -X (East)

segments = [
    {"start": (-5, -130), "end": (125, -130), "heading": 0},   # Top border, facing North
    {"start": (125, -130), "end": (125, -244), "heading": 64}, # Right border, facing West
    {"start": (125, -244), "end": (-5, -244), "heading": 128}  # Bottom border, facing South
]

def dist(p1, p2):
    return ((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)**0.5

# Calculate total length
total_length = sum(dist(s["start"], s["end"]) for s in segments)
num_vendors = len(vendor_ids)
spacing = total_length / (num_vendors - 1)

Z_COORD = -157.25

sql_statements = []
sql_statements.append("-- Repositioning 16 Class Armor Vendors along 3 borders")

current_segment = 0
distance_along_segment = 0.0

for i, vendor_id in enumerate(vendor_ids):
    target_distance = i * spacing
    
    # Find which segment this distance falls into
    seg_start_dist = 0.0
    seg = segments[0]
    for s in segments:
        seg_len = dist(s["start"], s["end"])
        if target_distance <= seg_start_dist + seg_len + 0.001: # +0.001 for float precision
            seg = s
            break
        seg_start_dist += seg_len
        
    # Interpolate position on this segment
    local_dist = target_distance - seg_start_dist
    seg_len = dist(seg["start"], seg["end"])
    if seg_len == 0:
        ratio = 0
    else:
        ratio = local_dist / seg_len
        
    x = seg["start"][0] + ratio * (seg["end"][0] - seg["start"][0])
    y = seg["start"][1] + ratio * (seg["end"][1] - seg["start"][1])
    heading = seg["heading"]
    
    # For corner vendors, we can adjust their heading to 45 degrees to look nice
    if abs(ratio - 0.0) < 0.01 and i != 0:
        # It's exactly on a corner, average the headings
        if heading == 64: # Top-Right corner
            heading = 32 # Facing North-West
        elif heading == 128: # Bottom-Right corner
            heading = 96 # Facing South-West

    sql = f"UPDATE spawn2 SET x = {x:.2f}, y = {y:.2f}, z = {Z_COORD:.2f}, heading = {heading} WHERE spawngroupID = {vendor_id};"
    sql_statements.append(sql)

output_file = "reposition_vendors_u_shape.sql"
with open(output_file, "w") as f:
    f.write("\n".join(sql_statements) + "\n")

print(f"Generated {output_file}")

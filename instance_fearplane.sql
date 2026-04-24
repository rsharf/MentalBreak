-- =============================================================================
-- Fearplane Instance (version 100) — Full setup
-- Creates Cazic Thule 2.0 clone, spawngroups, spawnentries, spawn2 entries
-- =============================================================================

-- ---- Cazic Thule 2.0 (harder version) ----
-- Double HP, +20% damage, higher resists, same loot table
INSERT INTO npc_types (
    id, name, level, hp, mana, attack_speed, AC,
    mindmg, maxdmg, npc_spells_id, loottable_id,
    special_abilities, race, class, bodytype, gender,
    texture, helmtexture, size, face,
    luclin_hairstyle, luclin_haircolor, luclin_eyecolor, luclin_eyecolor2,
    luclin_beardcolor, luclin_beard,
    d_melee_texture1, d_melee_texture2,
    runspeed, walkspeed, prim_melee_type, sec_melee_type,
    npc_faction_id, trackable, STR, STA, DEX, AGI, _INT, WIS, CHA,
    MR, CR, FR, PR, DR,
    spellscale, healscale, raid_target, qglobal
) VALUES (
    203002, 'Cazic_Thule', 73, 451000, 0, -35, 600,
    140, 380, 116, 291,
    '2,1^3,1,10^7,1^10,1^12,1^13,1^14,1^15,1^16,1^17,1^21,1^23,1^31,1',
    95, 5, 7, 2,
    0, 0, 40, 0,
    0, 0, 0, 1,
    0, 0,
    0, 0,
    2.25, 0, 28, 28,
    1361, 1, 350, 350, 350, 350, 350, 350, 350,
    200, 150, 425, 200, 200,
    125, 125, 1, 1
);

-- ---- Spawngroups for instance version 100 ----
SET @sg_base = 3290100;
SET @s2_base = 3270100;

INSERT INTO spawngroup (id, name, spawn_limit, dist, max_x, min_x, max_y, min_y, delay, mindelay, despawn, despawn_timer)
VALUES
(@sg_base +  1, 'inst_fp_Cazic_Thule',         0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  2, 'inst_fp_dracoliche',           0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  3, 'inst_fp_Tempest_Reaver',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  4, 'inst_fp_Dread',                0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  5, 'inst_fp_Fright',               0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  6, 'inst_fp_Terror',               0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  7, 'inst_fp_Wraith_Shissar',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  8, 'inst_fp_Irak_Altil',           0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  9, 'inst_fp_phantasm',             0, 0, 0, 0, 0, 0, 0, 15000, 0, 100);

-- ---- Spawnentries ----
INSERT INTO spawnentry (spawngroupID, npcID, chance)
VALUES
(@sg_base + 1, 72003, 100),   -- Cazic_Thule 1.0
(@sg_base + 2, 72090, 100),   -- a_dracoliche
(@sg_base + 3, 72012, 100),   -- #The_Tempest_Reaver
(@sg_base + 4, 72000, 100),   -- Dread
(@sg_base + 5, 72004, 100),   -- Fright
(@sg_base + 6, 72002, 100),   -- Terror
(@sg_base + 7, 72001, 100),   -- Wraith_of_a_Shissar
(@sg_base + 8, 72078, 100),   -- Irak_Altil
(@sg_base + 9, 72102, 100);   -- a_phantasm

-- ---- spawn2 entries (version 100 — instance only) ----
-- Coordinates from original version 0 spawn locations
INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime, variance, pathgrid, _condition, cond_value, animation)
VALUES
(@s2_base + 1, @sg_base + 1, 'fearplane', 100, -163.2,  549.0,  18.9, 235.0, 86400, 0, 0, 0, 1, 0),  -- Cazic_Thule
(@s2_base + 2, @sg_base + 2, 'fearplane', 100, -245.1, -139.6,   1.5, 327.5, 86400, 0, 0, 0, 1, 0),  -- a_dracoliche
(@s2_base + 3, @sg_base + 3, 'fearplane', 100, -583.0, -437.0,   5.0, 108.0, 86400, 0, 0, 0, 1, 0),  -- #The_Tempest_Reaver
(@s2_base + 4, @sg_base + 4, 'fearplane', 100,-1201.0, -635.0, 148.0,   1.0, 86400, 0, 0, 0, 1, 0),  -- Dread
(@s2_base + 5, @sg_base + 5, 'fearplane', 100, -358.0, -636.0, 135.2, 384.0, 86400, 0, 0, 0, 1, 0),  -- Fright
(@s2_base + 6, @sg_base + 6, 'fearplane', 100, -365.0,  199.0, 125.2, 261.0, 86400, 0, 0, 0, 1, 0),  -- Terror
(@s2_base + 7, @sg_base + 7, 'fearplane', 100,  413.1,  804.5, 206.5, 383.0, 86400, 0, 0, 0, 1, 0),  -- Wraith_of_a_Shissar
(@s2_base + 8, @sg_base + 8, 'fearplane', 100, -713.9,  411.9,   2.5,   0.0, 86400, 0, 0, 0, 1, 0),  -- Irak_Altil
(@s2_base + 9, @sg_base + 9, 'fearplane', 100, -829.2, 1184.9,  18.2, 423.5, 86400, 0, 0, 0, 1, 0);  -- a_phantasm

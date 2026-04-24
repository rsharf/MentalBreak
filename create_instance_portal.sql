-- ============================================================
-- Instance Portal NPC + Instance Boss (Innoruuk Clone)
-- Created: 2026-04-06
-- ============================================================

-- -------------------------------------------------
-- 1) Portal NPC (ID 203000) - Stationary, Unattackable
-- -------------------------------------------------
REPLACE INTO `npc_types` (
    `id`, `name`, `level`, `race`, `class`, `bodytype`,
    `hp`, `mana`, `gender`, `texture`, `helmtexture`,
    `runspeed`, `special_abilities`, `findable`, `trackable`,
    `raid_target`
) VALUES (
    203000, 'Instance_Portal', 75, 1, 1, 1,
    100000, 0, 0, 3, 0,
    0, '24,1', 1, 0,
    0
);

-- -------------------------------------------------
-- 2) Spawn Portal NPC in PoK (poknowledge)
-- -------------------------------------------------
REPLACE INTO `spawngroup` (`id`, `name`) VALUES (203000, 'Instance_Portal');

REPLACE INTO `spawnentry` (`spawngroupID`, `npcID`, `chance`) VALUES (203000, 203000, 100);

REPLACE INTO `spawn2` (
    `id`, `spawngroupID`, `zone`, `version`,
    `x`, `y`, `z`, `heading`, `respawntime`
) VALUES (
    203000, 203000, 'poknowledge', 0,
    -80, -160, -156, 0, 1200
);

-- -------------------------------------------------
-- 3) Instance Boss: Innoruuk Clone (ID 203001)
--    Stats copied from #Innoruuk (NPC 186107)
-- -------------------------------------------------
REPLACE INTO `npc_types` (
    `id`, `name`, `level`, `race`, `class`, `bodytype`,
    `hp`, `mana`, `gender`, `texture`, `helmtexture`,
    `loottable_id`, `mindmg`, `maxdmg`,
    `npcspecialattks`, `special_abilities`,
    `runspeed`,
    `MR`, `CR`, `DR`, `FR`, `PR`, `AC`, `ATK`,
    `STR`, `STA`, `DEX`, `AGI`, `_INT`, `WIS`, `CHA`,
    `hp_regen_rate`, `mana_regen_rate`, `attack_speed`,
    `raid_target`, `see_invis`, `see_hide`,
    `aggroradius`, `assistradius`,
    `private_corpse`, `trackable`
) VALUES (
    203001, 'Innoruuk', 75, 123, 1, 32,
    501000, 0, 2, 0, 0,
    6625, 100, 403,
    'ERFQMCNIDf', '2,1^4,1,0,50^7,1^13,1^14,1^15,1^16,1^17,1^21,1^26,1^31,1',
    2.25,
    150, 250, 150, 250, 150, 504, 130,
    290, 290, 290, 290, 290, 290, 290,
    500, 0, -35,
    1, 1, 1,
    500, 0,
    0, 1
);

-- -------------------------------------------------
-- 4) Verification
-- -------------------------------------------------
SELECT id, name, level FROM npc_types WHERE id IN (203000, 203001);
SELECT sg.id, sg.name FROM spawngroup sg WHERE sg.id = 203000;
SELECT s2.id, s2.zone, s2.x, s2.y, s2.z FROM spawn2 s2 WHERE s2.id = 203000;

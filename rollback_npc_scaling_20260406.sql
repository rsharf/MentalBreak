-- ROLLBACK: Restore NPC HP and Damage to pre-2026-04-06 values
-- Run this to undo the 50% HP reduction and 30% damage reduction

-- Step 1: Restore npc_scale_global_base from backup
UPDATE npc_scale_global_base g
JOIN npc_scale_global_base_backup_20260406 b
  ON g.type = b.type AND g.level = b.level AND g.zone_id_list = b.zone_id_list AND g.instance_version_list = b.instance_version_list
SET g.hp = b.hp,
    g.min_dmg = b.min_dmg,
    g.max_dmg = b.max_dmg;

-- Step 2: Restore npc_types from backup
UPDATE npc_types n
JOIN npc_types_backup_20260406 b ON n.id = b.id
SET n.hp = b.hp,
    n.mindmg = b.mindmg,
    n.maxdmg = b.maxdmg;

-- After running, use #repop in-game or restart server to apply
-- To drop backup tables after confirming rollback:
-- DROP TABLE npc_scale_global_base_backup_20260406;
-- DROP TABLE npc_types_backup_20260406;

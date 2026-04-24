-- Insert the NPC into npc_types
REPLACE INTO peq.npc_types (id, name, level, race, class, bodytype, hp, mana, texture, helmtexture, gender, d_melee_texture1, d_melee_texture2, runspeed)
VALUES (202999, 'Multiclass_Master', 70, 1, 1, 1, 10000, 10000, 2, 0, 0, 0, 0, 1.25);

-- Make the NPC unattackable (type 11), though standard GMs use faction/level settings usually. We'll set special_abilities.
UPDATE peq.npc_types SET special_abilities='24,1' WHERE id=202999;

-- Create spawngroup
REPLACE INTO peq.spawngroup (id, name, spawn_limit, dist, max_x, min_x, max_y, min_y, delay, mindelay)
VALUES (202999, 'Multiclass_Master', 1, 0, 0, 0, 0, 0, 45, 15);

-- Create spawnentry linking spawngroup to npc_type
REPLACE INTO peq.spawnentry (spawngroupID, npcID, chance)
VALUES (202999, 202999, 100);

-- Create spawn2 to place it in the world permanently in PoK
REPLACE INTO peq.spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime, variance, pathgrid, _condition)
VALUES (202999, 202999, 'poknowledge', 0, -54.00, -160.00, -156.00, 0, 1200, 0, 0, 0);

-- Create NPC
INSERT INTO npc_types (id, name, lastname, level, race, class, bodytype, hp, mana, gender, texture, helmtexture, size, merchant_id) 
VALUES (202917, 'Berserker_Elemental_Armor', 'Berserker Elemental Armor', 1, 1, 41, 1, 100, 0, 2, 0, 0, 5, 202917);

-- Add Inventory (Galladan's Stormwrath)
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 1, 55513); -- Coif
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 2, 55511); -- Tunic
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 3, 55508); -- Sleeves
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 4, 55510); -- Bracer
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 5, 55514); -- Gloves
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 6, 55512); -- Leggings
INSERT INTO merchantlist (merchantid, slot, item) VALUES (202917, 7, 55509); -- Boots

-- Setup Spawn
INSERT INTO spawngroup (id, name) VALUES (202917, 'Berserker_Elemental_Armor_spawngroup');
INSERT INTO spawnentry (spawngroupID, npcID, chance) VALUES (202917, 202917, 100);
INSERT INTO spawn2 (zone, version, spawngroupID, x, y, z, heading, respawntime) 
VALUES ('poknowledge', 0, 202917, -162.42, 129.64, -158.5, 0, 30);

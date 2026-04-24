
-- Epic Vendor (NPC ID 202916)
INSERT INTO npc_types (id, name, lastname, level, race, class, bodytype, hp, mana, gender, texture, helmtexture, merchant_id) 
VALUES (202916, 'Epic_Vendor', 'Epic Vendor', 70, 1, 41, 1, 1000000, 1000000, 2, 0, 0, 202916);

-- Spawngroup and Spawnentry for Epic Vendor
INSERT INTO spawngroup (id, name) VALUES (202916, 'Epic_Vendor_SG');
INSERT INTO spawnentry (spawngroupID, npcID, chance) VALUES (202916, 202916, 100);

-- Spawn2 for Epic Vendor (X, Y, Z coordinates from 2nd screenshot, offset for non-overlap)
-- base_x = -162.42, base_y = 49.64, spacing = 5. 15 vendors = 49.64 + 70 = 119.64.
INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime) 
VALUES (202916, 202916, 'poknowledge', 0, -162.42, 124.64, -158.50, 0, 30);

-- Merchant List for Epic Vendor
-- slot starts at 1
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202916, 1, 20542), -- Bard 1.0 Singing Short Sword
(202916, 2, 77640), -- Bard 2.0 Blade of Vesagran
(202916, 3, 8495),  -- Beastlord 1.0 Claw of the Savage Spirit
(202916, 4, 68299), -- Berserker 1.0 Kerasian Axe of Ire (Match)
(202916, 5, 18609), -- Berserker 2.0 Vengeful Taelosian Blood Axe
(202916, 6, 5532),  -- Cleric 1.0 Water Sprinkler of Nem Ankh
(202916, 7, 20490), -- Druid 1.0 Nature Walkers Scimitar
(202916, 8, 62880), -- Druid 2.0 Staff of Everliving Brambles
(202916, 9, 10650), -- Enchanter 1.0 Staff of the Serpent
(202916, 10, 16576), -- Enchanter 2.0 Staff of Phenomenal Power
(202916, 11, 20544), -- Magician 1.0 Scythe (User request)
(202916, 12, 10652), -- Monk 1.0 Celestial Fists
(202916, 13, 67742), -- Monk 2.0 Transcended Fistwraps of Immortality
(202916, 14, 20544), -- Necro 1.0 Scythe
(202916, 15, 64067), -- Necro 2.0 Deathwhisper
(202916, 16, 10099), -- Paladin 1.0 Fiery Defender
(202916, 17, 64031), -- Paladin 2.0 Redemption
(202916, 18, 20487), -- Ranger 1.0 Swiftwind
(202916, 19, 20488), -- Ranger 1.0 Earthcaller
(202916, 20, 62649), -- Ranger 2.0 Aurora
(202916, 21, 11057), -- Rogue 1.0 Ragebringer
(202916, 22, 14383), -- SK 1.0 Innoruuk's Curse
(202916, 23, 48136), -- SK 2.0 Innoruuk's Dark Blessing
(202916, 24, 10651), -- Shaman 1.0 Spear of Fate
(202916, 25, 57405), -- Shaman 2.0 Blessed Spiritstaff of the Heyokah
(202916, 26, 10908), -- Warrior 1.0 Jagged Blade of War
(202916, 27, 14341), -- Wizard 1.0 Staff of the Four
(202916, 28, 12665); -- Wizard 2.0 Staff of Prismatic Power

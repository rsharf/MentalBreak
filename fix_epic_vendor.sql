
-- Set price to 0 for all Epic items used by the vendor
UPDATE items SET price = 0 WHERE id IN (
    20542, 77640, 8495, 68299, 18609, 5532, 20490, 62880, 10650, 16576, 
    20544, 10652, 67742, 64067, 10099, 64031, 20487, 20488, 62649, 11057, 
    14383, 48136, 10651, 57405, 10908, 14341, 12665
);

-- Ensure the merchant list is populated for merchantid 202916
DELETE FROM merchantlist WHERE merchantid = 202916;

-- Based on desc_merchant_utf8.txt, columns are merchantid, slot, item
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202916, 1, 20542), -- Bard 1.0 Singing Short Sword
(202916, 2, 77640), -- Bard 2.0 Blade of Vesagran
(202916, 3, 8495),  -- Beastlord 1.0 Claw of the Savage Spirit
(202916, 4, 68299), -- Berserker 1.0 Kerasian Axe of Ire
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

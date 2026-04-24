-- Clear existing inventories for all Elemental Armor merchants
DELETE FROM merchantlist WHERE merchantid BETWEEN 202901 AND 202915 OR merchantid = 202917;

-- Bard: Rizlona's Fiery
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202901, 1, 9818),  -- Helm
(202901, 2, 47643), -- Chest
(202901, 3, 11444), -- Arms
(202901, 4, 11178), -- Wrist
(202901, 5, 12664), -- Hands
(202901, 6, 16771), -- Legs
(202901, 7, 19549); -- Feet

-- Beastlord: Dumul's Brute
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202902, 1, 9824),  -- Helm
(202902, 2, 47652), -- Chest
(202902, 3, 11450), -- Arms
(202902, 4, 11196), -- Wrist
(202902, 5, 13553), -- Hands
(202902, 6, 16787), -- Legs
(202902, 7, 20032); -- Feet

-- Cleric: Ultor's Faith
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202903, 1, 9827),  -- Helm
(202903, 2, 47646), -- Chest
(202903, 3, 32012), -- Arms
(202903, 4, 11199), -- Wrist
(202903, 5, 13563), -- Hands
(202903, 6, 16797), -- Legs
(202903, 7, 20074); -- Feet

-- Druid: Kerasha's Sylvan
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202904, 1, 9833),  -- Helm
(202904, 2, 47651), -- Chest
(202904, 3, 11575), -- Arms
(202904, 4, 11281), -- Wrist
(202904, 5, 13603), -- Hands
(202904, 6, 16811), -- Legs
(202904, 7, 20422); -- Feet

-- Enchanter: Romar's Visions
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202905, 1, 9836),  -- Helm
(202905, 2, 47656), -- Chest
(202905, 3, 11578), -- Arms
(202905, 4, 11298), -- Wrist
(202905, 5, 13614), -- Hands
(202905, 6, 16931), -- Legs
(202905, 7, 20425); -- Feet

-- Magician: Magi`Kot's Convergence
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202906, 1, 9944),  -- Helm
(202906, 2, 47655), -- Chest
(202906, 3, 11598), -- Arms
(202906, 4, 11303), -- Wrist
(202906, 5, 13619), -- Hands
(202906, 6, 19021), -- Legs
(202906, 7, 20428); -- Feet

-- Monk: Ton Po's Composure
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202907, 1, 9809),  -- Helm
(202907, 2, 47650), -- Chest
(202907, 3, 11435), -- Arms
(202907, 4, 11146), -- Wrist
(202907, 5, 12624), -- Hands
(202907, 6, 16727), -- Legs
(202907, 7, 19446); -- Feet

-- Necromancer: Miragul's Risen Souls
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202908, 1, 9947),  -- Helm
(202908, 2, 47653), -- Chest
(202908, 3, 11618), -- Arms
(202908, 4, 11306), -- Wrist
(202908, 5, 13623), -- Hands
(202908, 6, 19024), -- Legs
(202908, 7, 20431); -- Feet

-- Paladin: Trydan's Nobility
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202909, 1, 9812),  -- Helm
(202909, 2, 47644), -- Chest
(202909, 3, 11438), -- Arms
(202909, 4, 11163), -- Wrist
(202909, 5, 12627), -- Hands
(202909, 6, 16757), -- Legs
(202909, 7, 19449); -- Feet

-- Ranger: Askr's Thunderous
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202910, 1, 9821),  -- Helm
(202910, 2, 47647), -- Chest
(202910, 3, 11447), -- Arms
(202910, 4, 11193), -- Wrist
(202910, 5, 12816), -- Hands
(202910, 6, 16777), -- Legs
(202910, 7, 19838); -- Feet

-- Rogue: Bidilis' Elusive
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202911, 1, 9806),  -- Helm
(202911, 2, 47648), -- Chest
(202911, 3, 11432), -- Arms
(202911, 4, 11141), -- Wrist
(202911, 5, 12598), -- Hands
(202911, 6, 16717), -- Legs
(202911, 7, 19443); -- Feet

-- Shadow Knight: Grimror's Plagues
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202912, 1, 9815),  -- Helm
(202912, 2, 47645), -- Chest
(202912, 3, 11441), -- Arms
(202912, 4, 11173), -- Wrist
(202912, 5, 12637), -- Hands
(202912, 6, 16763), -- Legs
(202912, 7, 19546); -- Feet

-- Shaman: Rosrak's Primal
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202913, 1, 9830),  -- Helm
(202913, 2, 47649), -- Chest
(202913, 3, 11529), -- Arms
(202913, 4, 11278), -- Wrist
(202913, 5, 13579), -- Hands
(202913, 6, 16803), -- Legs
(202913, 7, 20078); -- Feet

-- Warrior: Raex's Destruction
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202914, 1, 9629),  -- Helm
(202914, 2, 47642), -- Chest
(202914, 3, 11429), -- Arms
(202914, 4, 11138), -- Wrist
(202914, 5, 12595), -- Hands
(202914, 6, 16693), -- Legs
(202914, 7, 19440); -- Feet

-- Wizard: Maelin's Lore
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202915, 1, 9950),  -- Helm
(202915, 2, 47654), -- Chest
(202915, 3, 11876), -- Arms
(202915, 4, 11309), -- Wrist
(202915, 5, 13627), -- Hands
(202915, 6, 19027), -- Legs
(202915, 7, 20434); -- Feet

-- Berserker: Galladan's Stormwrath
INSERT INTO merchantlist (merchantid, slot, item) VALUES
(202917, 1, 55513), -- Helm
(202917, 2, 55511), -- Chest
(202917, 3, 55508), -- Arms
(202917, 4, 55510), -- Wrist
(202917, 5, 55514), -- Hands
(202917, 6, 55512), -- Legs
(202917, 7, 55509); -- Feet

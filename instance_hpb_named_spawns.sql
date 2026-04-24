-- =============================================================================
-- Hateplaneb Instance (version 100) — Named NPC spawn2 entries
-- Creates dedicated spawngroups + spawnentries + spawn2 for version 100
-- so all named bosses/chests spawn automatically when the instance boots.
-- =============================================================================

-- Base IDs (above current max)
SET @sg_base = 3290000;
SET @s2_base = 3270000;

-- ----- Spawngroups (one per named NPC) -----
INSERT INTO spawngroup (id, name, spawn_limit, dist, max_x, min_x, max_y, min_y, delay, mindelay, despawn, despawn_timer)
VALUES
(@sg_base +  1, 'inst_hpb_Arcanist_VGimis',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  2, 'inst_hpb_Archon_GUvin',         0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  3, 'inst_hpb_Arch_Lich_TVaxok',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  4, 'inst_hpb_Dreadlord_MNoxin',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  5, 'inst_hpb_Overlord_RGahbsa',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  6, 'inst_hpb_Spy_Master_IKavin',    0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  7, 'inst_hpb_The_Deathrot_Knight',  0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  8, 'inst_hpb_Dread_Knight_TKamax',  0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base +  9, 'inst_hpb_Grandmaster_HQilm',    0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 10, 'inst_hpb_Grim_Abhorrent_Kaltik',0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 11, 'inst_hpb_Lord_of_Fury',         0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 12, 'inst_hpb_Master_DSamni',        0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 13, 'inst_hpb_Sorcerer_CGazin',      0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 14, 'inst_hpb_Templar_JRosix',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 15, 'inst_hpb_Warlock_JRath',        0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 16, 'inst_hpb_Warlord_EProsio',      0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 17, 'inst_hpb_grotesque_rat',        0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 18, 'inst_hpb_Assassin_ZJrix',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 19, 'inst_hpb_Evangelist_WRixxus',   0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 20, 'inst_hpb_hideous_rat',          0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 21, 'inst_hpb_Master_of_Vengence',   0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 22, 'inst_hpb_Mistress_AZara',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 23, 'inst_hpb_Mistress_of_Malevolence',0,0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 24, 'inst_hpb_hatebone_broodlord',   0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 25, 'inst_hpb_Corrupter_of_Life',    0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 26, 'inst_hpb_Hand_of_Maestro',      0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 27, 'inst_hpb_thought_destroyer',    0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 28, 'inst_hpb_frightful_chest',      0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 29, 'inst_hpb_phantom_chest_60',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 30, 'inst_hpb_phantom_chest_59',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 31, 'inst_hpb_phantom_chest_58',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 32, 'inst_hpb_phantom_chest_57',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 33, 'inst_hpb_eerie_chest',          0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 34, 'inst_hpb_haunted_chest_55',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 35, 'inst_hpb_haunted_chest_54',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 36, 'inst_hpb_haunted_chest_53',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 37, 'inst_hpb_haunted_chest_52',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 38, 'inst_hpb_haunted_chest_51',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 39, 'inst_hpb_haunted_chest_49',     0, 0, 0, 0, 0, 0, 0, 15000, 0, 100),
(@sg_base + 40, 'inst_hpb_Innoruuk_clone',       0, 0, 0, 0, 0, 0, 0, 15000, 0, 100);

-- ----- Spawnentries (link each spawngroup to its NPC) -----
INSERT INTO spawnentry (spawngroupID, npcID, chance)
VALUES
(@sg_base +  1, 186177, 100),  -- #Arcanist_V`Gimis
(@sg_base +  2, 186175, 100),  -- #Archon_G`Uvin
(@sg_base +  3, 186176, 100),  -- #Arch_Lich_T`Vaxok
(@sg_base +  4, 186174, 100),  -- #Dreadlord_M`Noxin
(@sg_base +  5, 186173, 100),  -- #Overlord_R`Gahbsa
(@sg_base +  6, 186172, 100),  -- #Spy_Master_I`Kavin
(@sg_base +  7, 186153, 100),  -- #The_Deathrot_Knight
(@sg_base +  8, 186170, 100),  -- #Dread_Knight_T`Kamax
(@sg_base +  9, 186183, 100),  -- #Grandmaster_H`Qilm
(@sg_base + 10, 186186, 100),  -- #Grim_Abhorrent_Kaltik
(@sg_base + 11, 186187, 100),  -- #Lord_of_Fury
(@sg_base + 12, 186184, 100),  -- #Master_D`Samni
(@sg_base + 13, 186168, 100),  -- #Sorcerer_C`Gazin
(@sg_base + 14, 186188, 100),  -- #Templar_J`Rosix
(@sg_base + 15, 186182, 100),  -- #Warlock_J`Rath
(@sg_base + 16, 186171, 100),  -- #Warlord_E`Prosio
(@sg_base + 17, 186185, 100),  -- a_grotesque_rat
(@sg_base + 18, 186167, 100),  -- #Assassin_Z`Jrix
(@sg_base + 19, 186169, 100),  -- #Evangelist_W`Rixxus
(@sg_base + 20, 186166, 100),  -- #a_hideous_rat
(@sg_base + 21, 186178, 100),  -- #Master_of_Vengence
(@sg_base + 22, 186151, 100),  -- #Mistress_A`Zara
(@sg_base + 23, 186181, 100),  -- #Mistress_of_Malevolence
(@sg_base + 24, 186180, 100),  -- a_hatebone_broodlord
(@sg_base + 25, 186189, 100),  -- Corrupter_of_Life
(@sg_base + 26, 186025, 100),  -- #Hand_of_the_Maestro
(@sg_base + 27, 186150, 100),  -- thought_destroyer
(@sg_base + 28, 186179, 100),  -- a_frightful_chest
(@sg_base + 29, 186124, 100),  -- a_phantom_chest (60)
(@sg_base + 30, 186066, 100),  -- a_phantom_chest (59)
(@sg_base + 31, 186088, 100),  -- a_phantom_chest (58)
(@sg_base + 32, 186033, 100),  -- a_phantom_chest (57)
(@sg_base + 33, 186162, 100),  -- #an_eerie_chest
(@sg_base + 34, 186043, 100),  -- a_haunted_chest (55)
(@sg_base + 35, 186019, 100),  -- a_haunted_chest (54)
(@sg_base + 36, 186036, 100),  -- a_haunted_chest (53)
(@sg_base + 37, 186041, 100),  -- a_haunted_chest (52)
(@sg_base + 38, 186047, 100),  -- a_haunted_chest (51)
(@sg_base + 39, 186063, 100),  -- a_haunted_chest (49)
(@sg_base + 40, 203001, 100);  -- Innoruuk (instance clone)

-- ----- spawn2 entries (version 100 — instance only) -----
INSERT INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime, variance, pathgrid, _condition, cond_value, animation)
VALUES
(@s2_base +  1, @sg_base +  1, 'hateplaneb', 100,  -79.0, -856.0,  4.8, 450.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  2, @sg_base +  2, 'hateplaneb', 100,  177.0, -795.0,  4.8, 339.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  3, @sg_base +  3, 'hateplaneb', 100,  129.0, -667.0,  4.8, 343.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  4, @sg_base +  4, 'hateplaneb', 100,  540.0, -874.0, 24.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  5, @sg_base +  5, 'hateplaneb', 100,  407.0, -732.0, 24.8, 378.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  6, @sg_base +  6, 'hateplaneb', 100,  276.0, -717.0,  4.8,  50.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  7, @sg_base +  7, 'hateplaneb', 100, -761.7,  187.1,  6.1, 126.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  8, @sg_base +  8, 'hateplaneb', 100,  379.0, -621.0,  4.8, 441.0, 86400, 0, 0, 0, 1, 0),
(@s2_base +  9, @sg_base +  9, 'hateplaneb', 100, -507.0, -495.0,  6.0, 308.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 10, @sg_base + 10, 'hateplaneb', 100, -737.0, -201.0,  6.0, 400.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 11, @sg_base + 11, 'hateplaneb', 100,  406.0,  -95.0, 10.0, 492.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 12, @sg_base + 12, 'hateplaneb', 100,  457.0, -318.0, 25.4, 299.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 13, @sg_base + 13, 'hateplaneb', 100,  138.0, -225.0,  4.8, 383.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 14, @sg_base + 14, 'hateplaneb', 100, -736.0, -858.0, 25.4, 369.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 15, @sg_base + 15, 'hateplaneb', 100,  389.0, -263.0,  8.8, 361.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 16, @sg_base + 16, 'hateplaneb', 100,  353.0, -497.0, 14.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 17, @sg_base + 17, 'hateplaneb', 100, -533.0, -197.0,  8.5, 283.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 18, @sg_base + 18, 'hateplaneb', 100,   71.0, -381.0,  4.8, 255.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 19, @sg_base + 19, 'hateplaneb', 100,  532.0, -520.0,  4.8, 131.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 20, @sg_base + 20, 'hateplaneb', 100, -825.0,  353.9,  8.5, 256.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 21, @sg_base + 21, 'hateplaneb', 100,  114.0,  -53.0,  6.0, 238.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 22, @sg_base + 22, 'hateplaneb', 100, -814.0, -549.0,  5.4, 500.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 23, @sg_base + 23, 'hateplaneb', 100,  562.0, -409.0, 26.0, 406.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 24, @sg_base + 24, 'hateplaneb', 100,  297.0, -266.0,  2.2, 442.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 25, @sg_base + 25, 'hateplaneb', 100, -427.0, -350.0,  7.0,  10.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 26, @sg_base + 26, 'hateplaneb', 100, -185.0, -120.0, 29.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 27, @sg_base + 27, 'hateplaneb', 100, -214.0, -615.0,  3.1, 311.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 28, @sg_base + 28, 'hateplaneb', 100,  471.0, -120.0,  4.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 29, @sg_base + 29, 'hateplaneb', 100, -394.0, -649.0,  4.8, 215.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 30, @sg_base + 30, 'hateplaneb', 100,  471.0, -120.0,  4.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 31, @sg_base + 31, 'hateplaneb', 100, -725.9, -671.9,  3.8, 256.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 32, @sg_base + 32, 'hateplaneb', 100, -712.9, -206.9,  3.8, 256.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 33, @sg_base + 33, 'hateplaneb', 100, -242.0,  600.0,  4.8, 138.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 34, @sg_base + 34, 'hateplaneb', 100, -189.0,  518.0,  4.8, 421.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 35, @sg_base + 35, 'hateplaneb', 100, -649.0,  364.0,  3.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 36, @sg_base + 36, 'hateplaneb', 100, -600.0,  417.0,  4.8,  28.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 37, @sg_base + 37, 'hateplaneb', 100, -782.0,  298.0,  3.8, 128.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 38, @sg_base + 38, 'hateplaneb', 100, -761.9,  630.0,  3.8, 256.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 39, @sg_base + 39, 'hateplaneb', 100, -793.0,  684.0,  4.8,   0.0, 86400, 0, 0, 0, 1, 0),
(@s2_base + 40, @sg_base + 40, 'hateplaneb', 100, -420.0,-1292.0, 25.0, 255.0, 86400, 0, 0, 0, 1, 0);

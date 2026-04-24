-- Fix exp_mod at levels 56-70
-- Level 55: stay at 2.07 (user likes 2% per red)
-- Level 65: reduce to 0.74 (cuts yellow from 17% to ~5%)
-- Linear taper: drop of 0.133 per level from 56 to 65
-- Levels 66-70: hold at 0.74

UPDATE level_exp_mods SET exp_mod = 1.94 WHERE level = 56;
UPDATE level_exp_mods SET exp_mod = 1.81 WHERE level = 57;
UPDATE level_exp_mods SET exp_mod = 1.67 WHERE level = 58;
UPDATE level_exp_mods SET exp_mod = 1.54 WHERE level = 59;
UPDATE level_exp_mods SET exp_mod = 1.41 WHERE level = 60;
UPDATE level_exp_mods SET exp_mod = 1.27 WHERE level = 61;
UPDATE level_exp_mods SET exp_mod = 1.14 WHERE level = 62;
UPDATE level_exp_mods SET exp_mod = 1.01 WHERE level = 63;
UPDATE level_exp_mods SET exp_mod = 0.87 WHERE level = 64;
UPDATE level_exp_mods SET exp_mod = 0.74 WHERE level = 65;
UPDATE level_exp_mods SET exp_mod = 0.74 WHERE level BETWEEN 66 AND 100;

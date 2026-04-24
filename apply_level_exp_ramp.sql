-- Scale exp_mod and aa_exp_mod from 1.0 at level 30 to 2.5 at level 65
-- Formula: mod = 1.0 + (level - 30) * 1.5 / 35
-- Levels 1-29: unchanged (1.0)
-- Levels 66-70: hold at 2.5 (same as 65)

-- Levels 30-65: linear ramp
UPDATE level_exp_mods SET exp_mod = ROUND(1.0 + (level - 30) * 1.5 / 35, 2), aa_exp_mod = ROUND(1.0 + (level - 30) * 1.5 / 35, 2) WHERE level BETWEEN 30 AND 65;

-- Levels 66-70+: hold at the level 65 value (2.5)
UPDATE level_exp_mods SET exp_mod = 2.5, aa_exp_mod = 2.5 WHERE level BETWEEN 66 AND 100;

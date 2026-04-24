-- Taper aa_exp_mod from levels 56-65
-- Level 55: keep at 2.07 (user likes ~7% per red)
-- Level 65: reduce to 1.25 (halves AA from ~100% to ~50% per red)
-- Linear taper: drop of 0.082 per level from 56 to 65
-- Levels 66-70: hold at 1.25

UPDATE level_exp_mods SET aa_exp_mod = 1.99 WHERE level = 56;
UPDATE level_exp_mods SET aa_exp_mod = 1.91 WHERE level = 57;
UPDATE level_exp_mods SET aa_exp_mod = 1.82 WHERE level = 58;
UPDATE level_exp_mods SET aa_exp_mod = 1.74 WHERE level = 59;
UPDATE level_exp_mods SET aa_exp_mod = 1.66 WHERE level = 60;
UPDATE level_exp_mods SET aa_exp_mod = 1.57 WHERE level = 61;
UPDATE level_exp_mods SET aa_exp_mod = 1.49 WHERE level = 62;
UPDATE level_exp_mods SET aa_exp_mod = 1.41 WHERE level = 63;
UPDATE level_exp_mods SET aa_exp_mod = 1.33 WHERE level = 64;
UPDATE level_exp_mods SET aa_exp_mod = 1.25 WHERE level = 65;
UPDATE level_exp_mods SET aa_exp_mod = 1.25 WHERE level BETWEEN 66 AND 100;

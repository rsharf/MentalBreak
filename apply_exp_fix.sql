-- ============================================
-- EXP CALIBRATION: 40% faster than standard EQ
-- Standard = 1.0, so target = 1.4
-- ============================================

-- 1. Set ExpMultiplier to 1.4 (40% faster than standard 1.0)
UPDATE rule_values SET rule_value = '1.4' WHERE rule_name = 'Character:ExpMultiplier';

-- 2. Set AAExpMultiplier to 1.4 
UPDATE rule_values SET rule_value = '1.4' WHERE rule_name = 'Character:AAExpMultiplier';

-- 3. Set GroupExpMultiplier to 1.0 (standard - group size bonuses handle the rest)
UPDATE rule_values SET rule_value = '1.0' WHERE rule_name = 'Character:GroupExpMultiplier';

-- 4. Set con modifiers to standard live-like values (value/100)
-- Green: 20% (low XP for trivial mobs)
UPDATE rule_values SET rule_value = '20' WHERE rule_name = 'Character:GreenModifier';

-- Light Blue: 80% (slightly reduced)
UPDATE rule_values SET rule_value = '80' WHERE rule_name = 'Character:LightBlueModifier';

-- Blue: 100% (full XP - appropriate challenge)
UPDATE rule_values SET rule_value = '100' WHERE rule_name = 'Character:BlueModifier';

-- White: 100% (equal level = full XP)
UPDATE rule_values SET rule_value = '100' WHERE rule_name = 'Character:WhiteModifier';

-- Yellow: 125% (bonus for harder mobs)
UPDATE rule_values SET rule_value = '125' WHERE rule_name = 'Character:YellowModifier';

-- Red: 150% (big bonus for dangerous mobs)
UPDATE rule_values SET rule_value = '150' WHERE rule_name = 'Character:RedModifier';

-- 5. Reset level_exp_mods to 1.0 (standard, no per-level bonus)
-- Was 5.0 which was giving 5x XP at every level!
UPDATE level_exp_mods SET exp_mod = 1.0, aa_exp_mod = 1.0;

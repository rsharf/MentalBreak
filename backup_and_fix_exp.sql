-- Backup current exp rules
CREATE TABLE IF NOT EXISTS exp_rules_backup_20260406 AS
SELECT * FROM rule_values
WHERE rule_name IN (
  'Character:ExpMultiplier',
  'Character:AAExpMultiplier',
  'Character:GroupExpMultiplier',
  'Character:GreenModifier',
  'Character:LightBlueModifier',
  'Character:BlueModifier',
  'Character:WhiteModifier',
  'Character:YellowModifier',
  'Character:RedModifier'
);

-- Backup level_exp_mods
CREATE TABLE IF NOT EXISTS level_exp_mods_backup_20260406 AS
SELECT * FROM level_exp_mods;

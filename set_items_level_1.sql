-- Update all items to have a required level of 1 and recommended level of 1
UPDATE items SET reqlevel = 1, reclevel = 1;

-- Update item properties:
-- loregroup = 0: Not Lore
-- nodrop = 0: Tradable (Not No Drop)
-- norent = 1: Permanent (Not No Rent)
UPDATE items SET loregroup = 0, nodrop = 0, norent = 1;

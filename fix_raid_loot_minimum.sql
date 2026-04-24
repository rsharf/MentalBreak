-- =============================================================================
-- FIX: Ensure all raid targets drop at least 2 items from their loot tables
-- =============================================================================
-- This script modifies loottable_entries for raid target NPCs so that the
-- guaranteed minimum drops (sum of mindrop across all 100% probability entries)
-- is at least 2.
--
-- The fix is applied in 3 steps:
--   Step 1: Set mindrop=1 on entries with droplimit>=1 that currently have mindrop=0
--   Step 2: For tables still under 2, increase droplimit+mindrop to 2 on single-entry
--           tables where the lootdrop has >=2 items
--   Step 3: For droplimit=0 entries (individual rolls), set mindrop=2 where lootdrop has >=2 items
-- =============================================================================

-- Create a temp table of raid-target loottable IDs that need fixing
DROP TEMPORARY TABLE IF EXISTS raid_loot_to_fix;
CREATE TEMPORARY TABLE raid_loot_to_fix AS
SELECT DISTINCT lte.loottable_id
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('Raid loottables needing fix: ', COUNT(*)) AS status FROM raid_loot_to_fix;

-- =============================================================================
-- STEP 1: Set mindrop=1 where droplimit >= 1, mindrop = 0, probability >= 100
-- This guarantees at least 1 item drops from each such entry
-- =============================================================================
UPDATE loottable_entries lte
JOIN raid_loot_to_fix rlf ON rlf.loottable_id = lte.loottable_id
SET lte.mindrop = 1
WHERE lte.probability >= 100
  AND lte.mindrop = 0
  AND lte.droplimit >= 1;

SELECT CONCAT('Step 1 done. Rows updated: ', ROW_COUNT()) AS status;

-- Recalculate which loottables still need fixing after step 1
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low;
CREATE TEMPORARY TABLE raid_loot_still_low AS
SELECT lte.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS current_min,
    COUNT(*) AS num_entries
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('After step 1, still need fix: ', COUNT(*)) AS status FROM raid_loot_still_low;

-- =============================================================================
-- STEP 2: For tables still under 2 — bump droplimit and mindrop to 2 on entries
-- where droplimit = 1 and the associated lootdrop has >= 2 items
-- =============================================================================
UPDATE loottable_entries lte
JOIN raid_loot_still_low rsl ON rsl.loottable_id = lte.loottable_id
SET lte.droplimit = 2, lte.mindrop = 2
WHERE lte.probability >= 100
  AND lte.droplimit = 1
  AND (SELECT COUNT(*) FROM lootdrop_entries lde WHERE lde.lootdrop_id = lte.lootdrop_id) >= 2
  -- Only bump ONE entry per loottable (the one with the most items)
  AND lte.lootdrop_id = (
    SELECT sub.lootdrop_id FROM (
      SELECT lte2.lootdrop_id,
        (SELECT COUNT(*) FROM lootdrop_entries lde2 WHERE lde2.lootdrop_id = lte2.lootdrop_id) AS item_ct
      FROM loottable_entries lte2
      WHERE lte2.loottable_id = lte.loottable_id
        AND lte2.probability >= 100
        AND lte2.droplimit = 1
        AND (SELECT COUNT(*) FROM lootdrop_entries lde3 WHERE lde3.lootdrop_id = lte2.lootdrop_id) >= 2
      ORDER BY item_ct DESC
      LIMIT 1
    ) sub
  );

SELECT CONCAT('Step 2 done. Rows updated: ', ROW_COUNT()) AS status;

-- Recalculate again
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low2;
CREATE TEMPORARY TABLE raid_loot_still_low2 AS
SELECT lte.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS current_min,
    COUNT(*) AS num_entries
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('After step 2, still need fix: ', COUNT(*)) AS status FROM raid_loot_still_low2;

-- =============================================================================
-- STEP 3: For entries with droplimit=0 (individual roll mode), set mindrop=2
-- where the lootdrop has >= 2 items. This guarantees at least 2 items always drop.
-- =============================================================================
UPDATE loottable_entries lte
JOIN raid_loot_still_low2 rsl ON rsl.loottable_id = lte.loottable_id
SET lte.mindrop = 2
WHERE lte.probability >= 100
  AND lte.droplimit = 0
  AND lte.mindrop < 2
  AND (SELECT COUNT(*) FROM lootdrop_entries lde WHERE lde.lootdrop_id = lte.lootdrop_id) >= 2
  -- Only fix ONE entry per loottable
  AND lte.lootdrop_id = (
    SELECT sub.lootdrop_id FROM (
      SELECT lte2.lootdrop_id
      FROM loottable_entries lte2
      WHERE lte2.loottable_id = lte.loottable_id
        AND lte2.probability >= 100
        AND lte2.droplimit = 0
        AND (SELECT COUNT(*) FROM lootdrop_entries lde2 WHERE lde2.lootdrop_id = lte2.lootdrop_id) >= 2
      ORDER BY (SELECT COUNT(*) FROM lootdrop_entries lde3 WHERE lde3.lootdrop_id = lte2.lootdrop_id) DESC
      LIMIT 1
    ) sub
  );

SELECT CONCAT('Step 3 done. Rows updated: ', ROW_COUNT()) AS status;

-- =============================================================================
-- FINAL REPORT: Show any raid loottables that still can't guarantee 2 drops
-- (these have too few items in their lootdrops to support mindrop=2)
-- =============================================================================
SELECT n.id AS npc_id, n.name, n.level, n.loottable_id, lt.name AS lt_name,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS guaranteed_min,
    GROUP_CONCAT(
        CONCAT('drop=', lte.lootdrop_id, ' lim=', lte.droplimit, ' min=', lte.mindrop,
               ' items=', (SELECT COUNT(*) FROM lootdrop_entries lde WHERE lde.lootdrop_id = lte.lootdrop_id))
        ORDER BY lte.lootdrop_id SEPARATOR ' | '
    ) AS entries
FROM npc_types n
JOIN loottable lt ON lt.id = n.loottable_id
JOIN loottable_entries lte ON lte.loottable_id = lt.id
WHERE n.raid_target = 1 AND n.loottable_id > 0
GROUP BY n.id, n.name, n.level, n.loottable_id, lt.name
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2
ORDER BY n.level DESC, n.name;

-- Cleanup temp tables
DROP TEMPORARY TABLE IF EXISTS raid_loot_to_fix;
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low;
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low2;

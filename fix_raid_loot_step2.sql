-- =============================================================================
-- Step 1 already ran (1662 entries updated: mindrop 0->1 where droplimit>=1)
-- 317 loottables still need fixing. This script handles Steps 2 and 3.
-- =============================================================================

-- Recalculate which loottables still need fixing
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low;
CREATE TEMPORARY TABLE raid_loot_still_low AS
SELECT lte.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS current_min
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('Loottables still needing fix: ', COUNT(*)) AS status FROM raid_loot_still_low;

-- =============================================================================
-- STEP 2: Build a target list of (loottable_id, lootdrop_id) pairs to bump
-- For each remaining loottable, pick the best entry (most items in its lootdrop,
-- droplimit=1, prob>=100) and bump to droplimit=2, mindrop=2
-- =============================================================================
DROP TEMPORARY TABLE IF EXISTS step2_targets;
CREATE TEMPORARY TABLE step2_targets AS
SELECT rsl.loottable_id, lte.lootdrop_id, item_counts.cnt AS item_count
FROM raid_loot_still_low rsl
JOIN loottable_entries lte ON lte.loottable_id = rsl.loottable_id
JOIN (
    SELECT lde.lootdrop_id, COUNT(*) AS cnt
    FROM lootdrop_entries lde
    GROUP BY lde.lootdrop_id
) item_counts ON item_counts.lootdrop_id = lte.lootdrop_id
WHERE lte.probability >= 100
  AND lte.droplimit = 1
  AND item_counts.cnt >= 2
GROUP BY rsl.loottable_id
-- This GROUP BY keeps only one row per loottable (the first one found)
;

SELECT CONCAT('Step 2 targets: ', COUNT(*)) AS status FROM step2_targets;

UPDATE loottable_entries lte
JOIN step2_targets t ON t.loottable_id = lte.loottable_id AND t.lootdrop_id = lte.lootdrop_id
SET lte.droplimit = 2, lte.mindrop = 2;

SELECT CONCAT('Step 2 done. Rows updated: ', ROW_COUNT()) AS status;

-- =============================================================================
-- STEP 3: For remaining tables, handle droplimit=0 entries (individual roll mode)
-- Set mindrop=2 where lootdrop has >= 2 items
-- =============================================================================
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low2;
CREATE TEMPORARY TABLE raid_loot_still_low2 AS
SELECT lte.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS current_min
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('After step 2, still need fix: ', COUNT(*)) AS status FROM raid_loot_still_low2;

DROP TEMPORARY TABLE IF EXISTS step3_targets;
CREATE TEMPORARY TABLE step3_targets AS
SELECT rsl.loottable_id, lte.lootdrop_id
FROM raid_loot_still_low2 rsl
JOIN loottable_entries lte ON lte.loottable_id = rsl.loottable_id
JOIN (
    SELECT lde.lootdrop_id, COUNT(*) AS cnt
    FROM lootdrop_entries lde
    GROUP BY lde.lootdrop_id
) item_counts ON item_counts.lootdrop_id = lte.lootdrop_id
WHERE lte.probability >= 100
  AND lte.droplimit = 0
  AND lte.mindrop < 2
  AND item_counts.cnt >= 2
GROUP BY rsl.loottable_id;

SELECT CONCAT('Step 3 targets: ', COUNT(*)) AS status FROM step3_targets;

UPDATE loottable_entries lte
JOIN step3_targets t ON t.loottable_id = lte.loottable_id AND t.lootdrop_id = lte.lootdrop_id
SET lte.mindrop = 2;

SELECT CONCAT('Step 3 done. Rows updated: ', ROW_COUNT()) AS status;

-- =============================================================================
-- STEP 4: Handle multi-entry tables that are at 1 guaranteed (need +1 more)
-- Pick an entry with droplimit >= 2 or droplimit = 0, and bump its mindrop by 1
-- =============================================================================
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low3;
CREATE TEMPORARY TABLE raid_loot_still_low3 AS
SELECT lte.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS current_min
FROM loottable_entries lte
JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
WHERE n.loottable_id > 0
GROUP BY lte.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2;

SELECT CONCAT('After step 3, still need fix: ', COUNT(*)) AS status FROM raid_loot_still_low3;

-- For these remaining, try to bump an entry with droplimit>=2 (has room for +1 mindrop)
DROP TEMPORARY TABLE IF EXISTS step4_targets;
CREATE TEMPORARY TABLE step4_targets AS
SELECT rsl.loottable_id, lte.lootdrop_id, lte.mindrop AS current_mindrop
FROM raid_loot_still_low3 rsl
JOIN loottable_entries lte ON lte.loottable_id = rsl.loottable_id
JOIN (
    SELECT lde.lootdrop_id, COUNT(*) AS cnt
    FROM lootdrop_entries lde
    GROUP BY lde.lootdrop_id
) item_counts ON item_counts.lootdrop_id = lte.lootdrop_id
WHERE lte.probability >= 100
  AND (lte.droplimit >= 2 OR lte.droplimit = 0)
  AND item_counts.cnt >= 2
  AND lte.mindrop < lte.droplimit OR lte.droplimit = 0
GROUP BY rsl.loottable_id;

SELECT CONCAT('Step 4 targets: ', COUNT(*)) AS status FROM step4_targets;

UPDATE loottable_entries lte
JOIN step4_targets t ON t.loottable_id = lte.loottable_id AND t.lootdrop_id = lte.lootdrop_id
SET lte.mindrop = CASE
    WHEN lte.droplimit = 0 THEN 2
    WHEN lte.mindrop + 1 <= lte.droplimit THEN lte.mindrop + 1
    ELSE lte.mindrop
END
WHERE lte.mindrop < 2;

SELECT CONCAT('Step 4 done. Rows updated: ', ROW_COUNT()) AS status;

-- =============================================================================
-- FINAL VERIFICATION: Show all raid loottables and their guaranteed drops
-- =============================================================================
SELECT
    CASE
        WHEN guaranteed_min >= 2 THEN 'OK (>=2 guaranteed)'
        WHEN guaranteed_min = 1 THEN 'PARTIAL (only 1 guaranteed)'
        ELSE 'STILL BROKEN (0 guaranteed)'
    END AS status,
    COUNT(*) AS num_loottables
FROM (
    SELECT lte.loottable_id,
        SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS guaranteed_min
    FROM loottable_entries lte
    JOIN npc_types n ON n.loottable_id = lte.loottable_id AND n.raid_target = 1
    WHERE n.loottable_id > 0
    GROUP BY lte.loottable_id
) sub
GROUP BY status
ORDER BY status;

-- Show any remaining problems (NPC names for unfixable cases)
SELECT n.id AS npc_id, n.name, n.level, n.loottable_id,
    SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) AS guaranteed_min,
    GROUP_CONCAT(
        CONCAT('drop=', lte.lootdrop_id, ' lim=', lte.droplimit, ' min=', lte.mindrop,
               ' items=', (SELECT COUNT(*) FROM lootdrop_entries lde WHERE lde.lootdrop_id = lte.lootdrop_id),
               ' prob=', lte.probability)
        ORDER BY lte.lootdrop_id SEPARATOR ' | '
    ) AS entries
FROM npc_types n
JOIN loottable_entries lte ON lte.loottable_id = n.loottable_id
WHERE n.raid_target = 1 AND n.loottable_id > 0
GROUP BY n.id, n.name, n.level, n.loottable_id
HAVING SUM(CASE WHEN lte.probability >= 100 THEN lte.mindrop ELSE 0 END) < 2
ORDER BY n.level DESC, n.name;

-- Cleanup
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low;
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low2;
DROP TEMPORARY TABLE IF EXISTS raid_loot_still_low3;
DROP TEMPORARY TABLE IF EXISTS step2_targets;
DROP TEMPORARY TABLE IF EXISTS step3_targets;
DROP TEMPORARY TABLE IF EXISTS step4_targets;

-- Fix stale multiclass data injected by the client DLL bug.
-- For any character that has never explicitly been granted a second/third class
-- via the Multiclass Master NPC, we should only have their primary (creation) class.
--
-- This deletes all non-primary rows from character_classes, leaving only the
-- is_primary=1 row.  Characters who legitimately multiclassed via GrantMulticlass
-- will have their rows re-seeded correctly on next login by LoadMultiClassFromDB.
--
-- If you want to be more targeted, first check which characters are affected:
-- SELECT cc.char_id, cc.class_id, cc.is_primary, cd.name, cd.class
-- FROM character_classes cc
-- JOIN character_data cd ON cd.id = cc.char_id
-- WHERE cc.is_primary = 0
-- ORDER BY cc.char_id;

-- Remove all non-primary (stale) class rows
DELETE FROM character_classes WHERE is_primary = 0;

-- Verify what remains
SELECT cc.char_id, cc.class_id, cc.is_primary, cd.name
FROM character_classes cc
JOIN character_data cd ON cd.id = cc.char_id
ORDER BY cc.char_id;

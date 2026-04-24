-- Fix SayLink (SL) infrastructure for #reload and quest saylinks.
-- Ensures the saylink table exists and the proxy item (ID 1001) is present.

-- Create the saylink table if it does not exist
CREATE TABLE IF NOT EXISTS peq.saylink (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `phrase` VARCHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Ensure item 1001 (SayLink proxy item) exists in the items table.
-- This item is required by the SayLinkEngine (SLE) to render clickable links.
-- If item 1001 already exists, this INSERT is safely ignored.
INSERT IGNORE INTO peq.items (id, Name, itemtype, icon)
VALUES (1001, 'SayLink', 0, 500);

-- Create character_classes table for the Multiclass System (MCS).
-- Used by C++ server code (client.cpp, multiclass.cpp) to persist class selections.
CREATE TABLE IF NOT EXISTS peq.character_classes (
  `char_id` INT(11) UNSIGNED NOT NULL,
  `class_id` TINYINT(3) UNSIGNED NOT NULL,
  `is_primary` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_id`, `class_id`),
  KEY `idx_char_id` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

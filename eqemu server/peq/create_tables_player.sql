-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: mariadb    Database: peq
-- ------------------------------------------------------
-- Server version	10.5.4-MariaDB-1:10.5.4+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `charname` varchar(64) NOT NULL DEFAULT '',
  `auto_login_charname` varchar(64) NOT NULL DEFAULT '',
  `sharedplat` int(11) unsigned NOT NULL DEFAULT 0,
  `password` varchar(50) NOT NULL DEFAULT '',
  `status` int(5) NOT NULL DEFAULT 0,
  `ls_id` varchar(64) DEFAULT 'eqemu',
  `lsaccount_id` int(11) unsigned DEFAULT NULL,
  `gmspeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `invulnerable` tinyint(4) DEFAULT 0,
  `flymode` tinyint(4) DEFAULT 0,
  `ignore_tells` tinyint(4) DEFAULT 0,
  `revoked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `karma` int(5) unsigned NOT NULL DEFAULT 0,
  `minilogin_ip` varchar(32) NOT NULL DEFAULT '',
  `hideme` tinyint(4) NOT NULL DEFAULT 0,
  `rulesflag` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `suspendeduntil` datetime DEFAULT NULL,
  `time_creation` int(10) unsigned NOT NULL DEFAULT 0,
  `ban_reason` text DEFAULT NULL,
  `suspend_reason` text DEFAULT NULL,
  `crc_eqgame` text DEFAULT NULL,
  `crc_skillcaps` text DEFAULT NULL,
  `crc_basedata` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_ls_id` (`name`,`ls_id`),
  UNIQUE KEY `ls_id_lsaccount_id` (`ls_id`,`lsaccount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_ip`
--

DROP TABLE IF EXISTS `account_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_ip` (
  `accid` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(32) NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT 1,
  `lastused` timestamp NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `ip` (`accid`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_flags`
--

DROP TABLE IF EXISTS `account_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_flags` (
  `p_accid` int(10) unsigned NOT NULL,
  `p_flag` varchar(50) NOT NULL,
  `p_value` varchar(80) NOT NULL,
  PRIMARY KEY (`p_accid`,`p_flag`),
  KEY `p_accid` (`p_accid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_rewards`
--

DROP TABLE IF EXISTS `account_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_rewards` (
  `account_id` int(10) unsigned NOT NULL,
  `reward_id` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  UNIQUE KEY `account_reward` (`account_id`,`reward_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adventure_details`
--

DROP TABLE IF EXISTS `adventure_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adventure_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `adventure_id` smallint(5) unsigned NOT NULL,
  `instance_id` int(11) NOT NULL DEFAULT -1,
  `count` smallint(5) unsigned NOT NULL DEFAULT 0,
  `assassinate_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `time_created` int(10) unsigned NOT NULL DEFAULT 0,
  `time_zoned` int(10) unsigned NOT NULL DEFAULT 0,
  `time_completed` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adventure_stats`
--

DROP TABLE IF EXISTS `adventure_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adventure_stats` (
  `player_id` int(10) unsigned NOT NULL,
  `guk_wins` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `mir_wins` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `mmc_wins` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `ruj_wins` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `tak_wins` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `guk_losses` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `mir_losses` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `mmc_losses` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `ruj_losses` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `tak_losses` mediumint(8) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `player_id_2` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_entity_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_name` varchar(64) DEFAULT NULL,
  `char_zone_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_zone_instance_id` int(11) unsigned NOT NULL DEFAULT 0,
  `transaction_date` datetime DEFAULT NULL,
  `welcome_message` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `charid` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer_buy_lines`
--

DROP TABLE IF EXISTS `buyer_buy_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyer_buy_lines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `buyer_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `buy_slot_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `item_qty` int(11) NOT NULL DEFAULT 0,
  `item_price` int(11) NOT NULL DEFAULT 0,
  `item_icon` int(11) unsigned NOT NULL DEFAULT 0,
  `item_name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `buyerid_charid_buyslotid` (`buyer_id`,`char_id`,`buy_slot_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer_trade_items`
--

DROP TABLE IF EXISTS `buyer_trade_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyer_trade_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `buyer_buy_lines_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `item_qty` int(11) NOT NULL DEFAULT 0,
  `item_icon` int(11) NOT NULL DEFAULT 0,
  `item_name` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `buyerbuylinesid` (`buyer_buy_lines_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `char_recipe_list`
--

DROP TABLE IF EXISTS `char_recipe_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_recipe_list` (
  `char_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `madecount` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_id`,`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_activities`
--

DROP TABLE IF EXISTS `character_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_activities` (
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `taskid` int(11) unsigned NOT NULL DEFAULT 0,
  `activityid` int(11) unsigned NOT NULL DEFAULT 0,
  `donecount` int(11) unsigned NOT NULL DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`charid`,`taskid`,`activityid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_alt_currency`
--

DROP TABLE IF EXISTS `character_alt_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_alt_currency` (
  `char_id` int(10) unsigned NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  PRIMARY KEY (`char_id`,`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_alternate_abilities`
--

DROP TABLE IF EXISTS `character_alternate_abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_alternate_abilities` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `aa_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `aa_value` smallint(11) unsigned NOT NULL DEFAULT 0,
  `charges` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`aa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_auras`
--

DROP TABLE IF EXISTS `character_auras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_auras` (
  `id` int(10) NOT NULL,
  `slot` tinyint(10) NOT NULL,
  `spell_id` int(10) NOT NULL,
  PRIMARY KEY (`id`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_bandolier`
--

DROP TABLE IF EXISTS `character_bandolier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_bandolier` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `bandolier_id` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `bandolier_slot` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  `icon` int(11) unsigned NOT NULL DEFAULT 0,
  `bandolier_name` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`bandolier_id`,`bandolier_slot`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_bind`
--

DROP TABLE IF EXISTS `character_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_bind` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slot` int(4) NOT NULL DEFAULT 0,
  `zone_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `instance_id` mediumint(11) unsigned NOT NULL DEFAULT 0,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `heading` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_buffs`
--

DROP TABLE IF EXISTS `character_buffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_buffs` (
  `character_id` int(10) unsigned NOT NULL,
  `slot_id` tinyint(3) unsigned NOT NULL,
  `spell_id` smallint(10) unsigned NOT NULL,
  `caster_level` tinyint(3) unsigned NOT NULL,
  `caster_name` varchar(64) NOT NULL,
  `ticsremaining` int(11) NOT NULL,
  `counters` int(10) unsigned NOT NULL,
  `numhits` int(10) unsigned NOT NULL,
  `melee_rune` int(10) unsigned NOT NULL,
  `magic_rune` int(10) unsigned NOT NULL,
  `persistent` tinyint(3) unsigned NOT NULL,
  `dot_rune` int(10) NOT NULL DEFAULT 0,
  `caston_x` int(10) NOT NULL DEFAULT 0,
  `caston_y` int(10) NOT NULL DEFAULT 0,
  `caston_z` int(10) NOT NULL DEFAULT 0,
  `ExtraDIChance` int(10) NOT NULL DEFAULT 0,
  `instrument_mod` int(10) NOT NULL DEFAULT 10,
  PRIMARY KEY (`character_id`,`slot_id`),
  KEY `character_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_corpse_items`
--

DROP TABLE IF EXISTS `character_corpse_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_corpse_items` (
  `corpse_id` int(11) unsigned NOT NULL,
  `equip_slot` int(11) unsigned NOT NULL,
  `item_id` int(11) unsigned DEFAULT NULL,
  `charges` int(11) unsigned DEFAULT NULL,
  `aug_1` int(11) unsigned DEFAULT 0,
  `aug_2` int(11) unsigned DEFAULT 0,
  `aug_3` int(11) unsigned DEFAULT 0,
  `aug_4` int(11) unsigned DEFAULT 0,
  `aug_5` int(11) unsigned DEFAULT 0,
  `aug_6` int(11) NOT NULL DEFAULT 0,
  `attuned` smallint(5) NOT NULL DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `ornamenticon` int(10) unsigned NOT NULL DEFAULT 0,
  `ornamentidfile` int(10) unsigned NOT NULL DEFAULT 0,
  `ornament_hero_model` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`corpse_id`,`equip_slot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_corpses`
--

DROP TABLE IF EXISTS `character_corpses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_corpses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `charname` varchar(64) NOT NULL DEFAULT '',
  `zone_id` smallint(5) NOT NULL DEFAULT 0,
  `instance_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `heading` float NOT NULL DEFAULT 0,
  `time_of_death` datetime NOT NULL DEFAULT current_timestamp(),
  `guild_consent_id` int(11) unsigned NOT NULL DEFAULT 0,
  `is_rezzed` tinyint(3) unsigned DEFAULT 0,
  `is_buried` tinyint(3) NOT NULL DEFAULT 0,
  `was_at_graveyard` tinyint(3) NOT NULL DEFAULT 0,
  `is_locked` tinyint(11) DEFAULT 0,
  `exp` int(11) unsigned DEFAULT 0,
  `size` int(11) unsigned DEFAULT 0,
  `level` int(11) unsigned DEFAULT 0,
  `race` int(11) unsigned DEFAULT 0,
  `gender` int(11) unsigned DEFAULT 0,
  `class` int(11) unsigned DEFAULT 0,
  `deity` int(11) unsigned DEFAULT 0,
  `texture` int(11) unsigned DEFAULT 0,
  `helm_texture` int(11) unsigned DEFAULT 0,
  `copper` int(11) unsigned DEFAULT 0,
  `silver` int(11) unsigned DEFAULT 0,
  `gold` int(11) unsigned DEFAULT 0,
  `platinum` int(11) unsigned DEFAULT 0,
  `hair_color` int(11) unsigned DEFAULT 0,
  `beard_color` int(11) unsigned DEFAULT 0,
  `eye_color_1` int(11) unsigned DEFAULT 0,
  `eye_color_2` int(11) unsigned DEFAULT 0,
  `hair_style` int(11) unsigned DEFAULT 0,
  `face` int(11) unsigned DEFAULT 0,
  `beard` int(11) unsigned DEFAULT 0,
  `drakkin_heritage` int(11) unsigned DEFAULT 0,
  `drakkin_tattoo` int(11) unsigned DEFAULT 0,
  `drakkin_details` int(11) unsigned DEFAULT 0,
  `wc_1` int(11) unsigned DEFAULT 0,
  `wc_2` int(11) unsigned DEFAULT 0,
  `wc_3` int(11) unsigned DEFAULT 0,
  `wc_4` int(11) unsigned DEFAULT 0,
  `wc_5` int(11) unsigned DEFAULT 0,
  `wc_6` int(11) unsigned DEFAULT 0,
  `wc_7` int(11) unsigned DEFAULT 0,
  `wc_8` int(11) unsigned DEFAULT 0,
  `wc_9` int(11) unsigned DEFAULT 0,
  `rez_time` int(11) unsigned NOT NULL DEFAULT 0,
  `gm_exp` int(11) unsigned NOT NULL DEFAULT 0,
  `killed_by` int(11) unsigned NOT NULL DEFAULT 0,
  `rezzable` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `entity_variables` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zoneid` (`zone_id`),
  KEY `instanceid` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_currency`
--

DROP TABLE IF EXISTS `character_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_currency` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `platinum` int(11) unsigned NOT NULL DEFAULT 0,
  `gold` int(11) unsigned NOT NULL DEFAULT 0,
  `silver` int(11) unsigned NOT NULL DEFAULT 0,
  `copper` int(11) unsigned NOT NULL DEFAULT 0,
  `platinum_bank` int(11) unsigned NOT NULL DEFAULT 0,
  `gold_bank` int(11) unsigned NOT NULL DEFAULT 0,
  `silver_bank` int(11) unsigned NOT NULL DEFAULT 0,
  `copper_bank` int(11) unsigned NOT NULL DEFAULT 0,
  `platinum_cursor` int(11) unsigned NOT NULL DEFAULT 0,
  `gold_cursor` int(11) unsigned NOT NULL DEFAULT 0,
  `silver_cursor` int(11) unsigned NOT NULL DEFAULT 0,
  `copper_cursor` int(11) unsigned NOT NULL DEFAULT 0,
  `radiant_crystals` int(11) unsigned NOT NULL DEFAULT 0,
  `career_radiant_crystals` int(11) unsigned NOT NULL DEFAULT 0,
  `ebon_crystals` int(11) unsigned NOT NULL DEFAULT 0,
  `career_ebon_crystals` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_data`
--

DROP TABLE IF EXISTS `character_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `last_name` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(32) NOT NULL DEFAULT '',
  `suffix` varchar(32) NOT NULL DEFAULT '',
  `zone_id` int(11) unsigned NOT NULL DEFAULT 0,
  `zone_instance` int(11) unsigned NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `x` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `heading` float NOT NULL DEFAULT 0,
  `gender` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `race` smallint(11) unsigned NOT NULL DEFAULT 0,
  `class` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `deity` int(11) unsigned NOT NULL DEFAULT 0,
  `birthday` int(11) unsigned NOT NULL DEFAULT 0,
  `last_login` int(11) unsigned NOT NULL DEFAULT 0,
  `time_played` int(11) unsigned NOT NULL DEFAULT 0,
  `level2` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `anon` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `gm` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `face` int(11) unsigned NOT NULL DEFAULT 0,
  `hair_color` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `hair_style` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `beard` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `beard_color` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `eye_color_1` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `eye_color_2` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `drakkin_heritage` int(11) unsigned NOT NULL DEFAULT 0,
  `drakkin_tattoo` int(11) unsigned NOT NULL DEFAULT 0,
  `drakkin_details` int(11) unsigned NOT NULL DEFAULT 0,
  `ability_time_seconds` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `ability_number` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `ability_time_minutes` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `ability_time_hours` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `exp` int(11) unsigned NOT NULL DEFAULT 0,
  `exp_enabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `aa_points_spent` int(11) unsigned NOT NULL DEFAULT 0,
  `aa_exp` int(11) unsigned NOT NULL DEFAULT 0,
  `aa_points` int(11) unsigned NOT NULL DEFAULT 0,
  `group_leadership_exp` int(11) unsigned NOT NULL DEFAULT 0,
  `raid_leadership_exp` int(11) unsigned NOT NULL DEFAULT 0,
  `group_leadership_points` int(11) unsigned NOT NULL DEFAULT 0,
  `raid_leadership_points` int(11) unsigned NOT NULL DEFAULT 0,
  `points` int(11) unsigned NOT NULL DEFAULT 0,
  `cur_hp` int(11) unsigned NOT NULL DEFAULT 0,
  `mana` int(11) unsigned NOT NULL DEFAULT 0,
  `endurance` int(11) unsigned NOT NULL DEFAULT 0,
  `intoxication` int(11) unsigned NOT NULL DEFAULT 0,
  `str` int(11) unsigned NOT NULL DEFAULT 0,
  `sta` int(11) unsigned NOT NULL DEFAULT 0,
  `cha` int(11) unsigned NOT NULL DEFAULT 0,
  `dex` int(11) unsigned NOT NULL DEFAULT 0,
  `int` int(11) unsigned NOT NULL DEFAULT 0,
  `agi` int(11) unsigned NOT NULL DEFAULT 0,
  `wis` int(11) unsigned NOT NULL DEFAULT 0,
  `extra_haste` int(11) NOT NULL DEFAULT 0,
  `zone_change_count` int(11) unsigned NOT NULL DEFAULT 0,
  `toxicity` int(11) unsigned NOT NULL DEFAULT 0,
  `hunger_level` int(11) unsigned NOT NULL DEFAULT 0,
  `thirst_level` int(11) unsigned NOT NULL DEFAULT 0,
  `ability_up` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_guk` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_mir` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_mmc` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_ruj` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_tak` int(11) unsigned NOT NULL DEFAULT 0,
  `ldon_points_available` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_time_remaining` int(11) unsigned NOT NULL DEFAULT 0,
  `career_tribute_points` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_points` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_active` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_status` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `pvp_kills` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_deaths` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_current_points` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_career_points` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_best_kill_streak` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_worst_death_streak` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_current_kill_streak` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp2` int(11) unsigned NOT NULL DEFAULT 0,
  `pvp_type` int(11) unsigned NOT NULL DEFAULT 0,
  `show_helm` int(11) unsigned NOT NULL DEFAULT 0,
  `group_auto_consent` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `raid_auto_consent` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `guild_auto_consent` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `leadership_exp_on` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `RestTimer` int(11) unsigned NOT NULL DEFAULT 0,
  `air_remaining` int(11) unsigned NOT NULL DEFAULT 0,
  `autosplit_enabled` int(11) unsigned NOT NULL DEFAULT 0,
  `lfp` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `lfg` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `mailkey` char(16) NOT NULL DEFAULT '',
  `xtargets` tinyint(3) unsigned NOT NULL DEFAULT 5,
  `first_login` int(11) unsigned NOT NULL DEFAULT 0,
  `ingame` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `e_aa_effects` int(11) unsigned NOT NULL DEFAULT 0,
  `e_percent_to_aa` int(11) unsigned NOT NULL DEFAULT 0,
  `e_expended_aa_spent` int(11) unsigned NOT NULL DEFAULT 0,
  `aa_points_spent_old` int(11) unsigned NOT NULL DEFAULT 0,
  `aa_points_old` int(11) unsigned NOT NULL DEFAULT 0,
  `e_last_invsnapshot` int(11) unsigned NOT NULL DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `illusion_block` tinyint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_disciplines`
--

DROP TABLE IF EXISTS `character_disciplines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_disciplines` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `slot_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `disc_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_enabledtasks`
--

DROP TABLE IF EXISTS `character_enabledtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_enabledtasks` (
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `taskid` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`,`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_expedition_lockouts`
--

DROP TABLE IF EXISTS `character_expedition_lockouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_expedition_lockouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned NOT NULL,
  `expedition_name` varchar(128) NOT NULL,
  `event_name` varchar(256) NOT NULL,
  `expire_time` datetime NOT NULL DEFAULT current_timestamp(),
  `duration` int(10) unsigned NOT NULL DEFAULT 0,
  `from_expedition_uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `character_id_expedition_name_event_name` (`character_id`,`expedition_name`,`event_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_exp_modifiers`
--

DROP TABLE IF EXISTS `character_exp_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_exp_modifiers` (
  `character_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `instance_version` int(11) NOT NULL DEFAULT -1,
  `aa_modifier` float NOT NULL DEFAULT 1,
  `exp_modifier` float NOT NULL DEFAULT 1,
  PRIMARY KEY (`character_id`,`zone_id`,`instance_version`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_evolving_items`
--

DROP TABLE IF EXISTS `character_evolving_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_evolving_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned DEFAULT 0,
  `item_id` int(10) unsigned DEFAULT 0,
  `activated` tinyint(1) unsigned DEFAULT 0,
  `equipped` tinyint(3) unsigned DEFAULT 0,
  `current_amount` bigint(20) DEFAULT 0,
  `progression` double(22,0) DEFAULT 0,
  `final_item_id` int(10) unsigned DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_inspect_messages`
--

DROP TABLE IF EXISTS `character_inspect_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_inspect_messages` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `inspect_message` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_instance_safereturns`
--

DROP TABLE IF EXISTS `character_instance_safereturns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_instance_safereturns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned NOT NULL,
  `instance_zone_id` int(11) NOT NULL DEFAULT 0,
  `instance_id` int(11) NOT NULL DEFAULT 0,
  `safe_zone_id` int(11) NOT NULL DEFAULT 0,
  `safe_x` float NOT NULL DEFAULT 0,
  `safe_y` float NOT NULL DEFAULT 0,
  `safe_z` float NOT NULL DEFAULT 0,
  `safe_heading` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `character_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_item_recast`
--

DROP TABLE IF EXISTS `character_item_recast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_item_recast` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `recast_type` int(11) unsigned NOT NULL DEFAULT 0,
  `timestamp` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`recast_type`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_languages`
--

DROP TABLE IF EXISTS `character_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_languages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `value` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`lang_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_leadership_abilities`
--

DROP TABLE IF EXISTS `character_leadership_abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_leadership_abilities` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `slot` smallint(11) unsigned NOT NULL DEFAULT 0,
  `rank` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_material`
--

DROP TABLE IF EXISTS `character_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_material` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slot` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `blue` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `green` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `red` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `use_tint` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `color` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_memmed_spells`
--

DROP TABLE IF EXISTS `character_memmed_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_memmed_spells` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `slot_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `spell_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_parcels`
--

DROP TABLE IF EXISTS `character_parcels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_parcels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(10) unsigned NOT NULL DEFAULT 0,
  `item_id` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_1` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_2` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_3` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_4` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_5` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_6` int(10) unsigned NOT NULL DEFAULT 0,
  `slot_id` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `evolve_amount` int(10) unsigned NOT NULL DEFAULT 0,
  `from_name` varchar(64) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `data_constraint` (`slot_id`,`char_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_parcels_containers`
--

DROP TABLE IF EXISTS `character_parcels_containers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_parcels_containers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parcels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `slot_id` int(10) unsigned NOT NULL DEFAULT 0,
  `item_id` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_1` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_2` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_3` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_4` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_5` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_6` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `evolve_amount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_character_parcels_id` (`parcels_id`) USING BTREE,
  CONSTRAINT `fk_character_parcels_id` FOREIGN KEY (`parcels_id`) REFERENCES `character_parcels` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet_buffs`
--

DROP TABLE IF EXISTS `character_pet_buffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet_buffs` (
  `char_id` int(11) NOT NULL,
  `pet` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `spell_id` int(11) NOT NULL,
  `caster_level` tinyint(4) NOT NULL DEFAULT 0,
  `castername` varchar(64) NOT NULL DEFAULT '',
  `ticsremaining` int(11) NOT NULL DEFAULT 0,
  `counters` int(11) NOT NULL DEFAULT 0,
  `numhits` int(11) NOT NULL DEFAULT 0,
  `rune` int(11) NOT NULL DEFAULT 0,
  `instrument_mod` tinyint(3) unsigned NOT NULL DEFAULT 10,
  PRIMARY KEY (`char_id`,`pet`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet_info`
--

DROP TABLE IF EXISTS `character_pet_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet_info` (
  `char_id` int(11) NOT NULL,
  `pet` int(11) NOT NULL,
  `petname` varchar(64) NOT NULL DEFAULT '',
  `petpower` int(11) NOT NULL DEFAULT 0,
  `spell_id` int(11) NOT NULL DEFAULT 0,
  `hp` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `size` float NOT NULL DEFAULT 0,
  `taunting` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`char_id`,`pet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet_inventory`
--

DROP TABLE IF EXISTS `character_pet_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet_inventory` (
  `char_id` int(11) NOT NULL,
  `pet` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`char_id`,`pet`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet_name`
--

DROP TABLE IF EXISTS `character_pet_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet_name` (
  `character_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_peqzone_flags`
--

DROP TABLE IF EXISTS `character_peqzone_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_peqzone_flags` (
  `id` int(11) NOT NULL DEFAULT 0,
  `zone_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`zone_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_potionbelt`
--

DROP TABLE IF EXISTS `character_potionbelt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_potionbelt` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `potion_id` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  `icon` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`potion_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_skills`
--

DROP TABLE IF EXISTS `character_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_skills` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `value` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`skill_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_spells`
--

DROP TABLE IF EXISTS `character_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_spells` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slot_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `spell_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`slot_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_stats_record`
--

DROP TABLE IF EXISTS `character_stats_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_stats_record` (
  `character_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `class` int(11) DEFAULT 0,
  `race` int(11) DEFAULT 0,
  `aa_points` int(11) DEFAULT 0,
  `hp` bigint(20) DEFAULT 0,
  `mana` bigint(20) DEFAULT 0,
  `endurance` bigint(20) DEFAULT 0,
  `ac` int(11) DEFAULT 0,
  `strength` int(11) DEFAULT 0,
  `stamina` int(11) DEFAULT 0,
  `dexterity` int(11) DEFAULT 0,
  `agility` int(11) DEFAULT 0,
  `intelligence` int(11) DEFAULT 0,
  `wisdom` int(11) DEFAULT 0,
  `charisma` int(11) DEFAULT 0,
  `magic_resist` int(11) DEFAULT 0,
  `fire_resist` int(11) DEFAULT 0,
  `cold_resist` int(11) DEFAULT 0,
  `poison_resist` int(11) DEFAULT 0,
  `disease_resist` int(11) DEFAULT 0,
  `corruption_resist` int(11) DEFAULT 0,
  `heroic_strength` int(11) DEFAULT 0,
  `heroic_stamina` int(11) DEFAULT 0,
  `heroic_dexterity` int(11) DEFAULT 0,
  `heroic_agility` int(11) DEFAULT 0,
  `heroic_intelligence` int(11) DEFAULT 0,
  `heroic_wisdom` int(11) DEFAULT 0,
  `heroic_charisma` int(11) DEFAULT 0,
  `heroic_magic_resist` int(11) DEFAULT 0,
  `heroic_fire_resist` int(11) DEFAULT 0,
  `heroic_cold_resist` int(11) DEFAULT 0,
  `heroic_poison_resist` int(11) DEFAULT 0,
  `heroic_disease_resist` int(11) DEFAULT 0,
  `heroic_corruption_resist` int(11) DEFAULT 0,
  `haste` int(11) DEFAULT 0,
  `accuracy` int(11) DEFAULT 0,
  `attack` int(11) DEFAULT 0,
  `avoidance` int(11) DEFAULT 0,
  `clairvoyance` int(11) DEFAULT 0,
  `combat_effects` int(11) DEFAULT 0,
  `damage_shield_mitigation` int(11) DEFAULT 0,
  `damage_shield` int(11) DEFAULT 0,
  `dot_shielding` int(11) DEFAULT 0,
  `hp_regen` int(11) DEFAULT 0,
  `mana_regen` int(11) DEFAULT 0,
  `endurance_regen` int(11) DEFAULT 0,
  `shielding` int(11) DEFAULT 0,
  `spell_damage` int(11) DEFAULT 0,
  `heal_amount` int(11) DEFAULT 0,
  `spell_shielding` int(11) DEFAULT 0,
  `strikethrough` int(11) DEFAULT 0,
  `stun_resist` int(11) DEFAULT 0,
  `backstab` int(11) DEFAULT 0,
  `wind` int(11) DEFAULT 0,
  `brass` int(11) DEFAULT 0,
  `string` int(11) DEFAULT 0,
  `percussion` int(11) DEFAULT 0,
  `singing` int(11) DEFAULT 0,
  `baking` int(11) DEFAULT 0,
  `alchemy` int(11) DEFAULT 0,
  `tailoring` int(11) DEFAULT 0,
  `blacksmithing` int(11) DEFAULT 0,
  `fletching` int(11) DEFAULT 0,
  `brewing` int(11) DEFAULT 0,
  `jewelry` int(11) DEFAULT 0,
  `pottery` int(11) DEFAULT 0,
  `research` int(11) DEFAULT 0,
  `alcohol` int(11) DEFAULT 0,
  `fishing` int(11) DEFAULT 0,
  `tinkering` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_task_timers`
--

DROP TABLE IF EXISTS `character_task_timers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_task_timers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned NOT NULL DEFAULT 0,
  `task_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timer_type` int(11) NOT NULL DEFAULT 0,
  `timer_group` int(11) NOT NULL DEFAULT 0,
  `expire_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `character_id` (`character_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_tasks`
--

DROP TABLE IF EXISTS `character_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_tasks` (
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `taskid` int(11) unsigned NOT NULL DEFAULT 0,
  `slot` int(11) unsigned NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `acceptedtime` int(11) unsigned DEFAULT NULL,
  `was_rewarded` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`,`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_tribute`
--

DROP TABLE IF EXISTS `character_tribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_tribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) unsigned NOT NULL DEFAULT 0,
  `tier` tinyint(11) unsigned NOT NULL DEFAULT 0,
  `tribute` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `idx_character_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `completed_tasks`
--

DROP TABLE IF EXISTS `completed_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_tasks` (
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `completedtime` int(11) unsigned NOT NULL DEFAULT 0,
  `taskid` int(11) unsigned NOT NULL DEFAULT 0,
  `activityid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`,`completedtime`,`taskid`,`activityid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_buckets`
--

DROP TABLE IF EXISTS `data_buckets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_buckets` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `expires` int(11) unsigned DEFAULT 0,
  `account_id` bigint(11) unsigned DEFAULT 0,
  `character_id` bigint(11) unsigned NOT NULL DEFAULT 0,
  `npc_id` int(11) unsigned NOT NULL DEFAULT 0,
  `bot_id` int(11) unsigned NOT NULL DEFAULT 0,
  `zone_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  `instance_id` smallint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keys` (`key`,`character_id`,`npc_id`,`bot_id`,`account_id`,`zone_id`,`instance_id`),
  KEY `idx_account_id_key` (`account_id`,`key`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_zone_instance_expires` (`zone_id`,`instance_id`,`expires`),
  KEY `idx_character_expires` (`character_id`,`expires`),
  KEY `idx_bot_expires` (`bot_id`,`expires`),
  KEY `idx_expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discovered_items`
--

DROP TABLE IF EXISTS `discovered_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discovered_items` (
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_name` varchar(64) NOT NULL DEFAULT '',
  `discovered_date` int(11) unsigned NOT NULL DEFAULT 0,
  `account_status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faction_values`
--

DROP TABLE IF EXISTS `faction_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faction_values` (
  `char_id` int(4) NOT NULL DEFAULT 0,
  `faction_id` int(4) NOT NULL DEFAULT 0,
  `current_value` smallint(6) NOT NULL DEFAULT 0,
  `temp` tinyint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_id`,`faction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `charid` int(10) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '1 = Friend, 0 = Ignore',
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`charid`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_bank`
--

DROP TABLE IF EXISTS `guild_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guild_id` int(10) unsigned NOT NULL DEFAULT 0,
  `area` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `slot` int(4) unsigned NOT NULL DEFAULT 0,
  `item_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_one_id` int(10) unsigned DEFAULT 0,
  `augment_two_id` int(10) unsigned DEFAULT 0,
  `augment_three_id` int(10) unsigned DEFAULT 0,
  `augment_four_id` int(10) unsigned DEFAULT 0,
  `augment_five_id` int(10) unsigned DEFAULT 0,
  `augment_six_id` int(10) unsigned DEFAULT 0,
  `quantity` int(10) NOT NULL DEFAULT 0,
  `donator` varchar(64) DEFAULT NULL,
  `permissions` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `who_for` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `area` (`area`),
  KEY `slot` (`slot`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_members`
--

DROP TABLE IF EXISTS `guild_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_members` (
  `char_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `rank` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `tribute_enable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `total_tribute` int(10) unsigned NOT NULL DEFAULT 0,
  `last_tribute` int(10) unsigned NOT NULL DEFAULT 0,
  `banker` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `public_note` text NOT NULL,
  `alt` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `online` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_permissions`
--

DROP TABLE IF EXISTS `guild_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `permission` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `perm_id_guild_id` (`perm_id`,`guild_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_ranks`
--

DROP TABLE IF EXISTS `guild_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_ranks` (
  `guild_id` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `rank` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `title` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`guild_id`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_relations`
--

DROP TABLE IF EXISTS `guild_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_relations` (
  `guild1` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `guild2` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `relation` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guild1`,`guild2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_tributes`
--

DROP TABLE IF EXISTS `guild_tributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_tributes` (
  `guild_id` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_id_1` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_id_1_tier` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_id_2` int(11) unsigned NOT NULL DEFAULT 0,
  `tribute_id_2_tier` int(11) unsigned NOT NULL DEFAULT 0,
  `time_remaining` int(11) unsigned NOT NULL DEFAULT 0,
  `enabled` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guild_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `leader` int(11) NOT NULL DEFAULT 0,
  `minstatus` smallint(5) NOT NULL DEFAULT 0,
  `motd` text NOT NULL,
  `tribute` int(10) unsigned NOT NULL DEFAULT 0,
  `motd_setter` varchar(64) NOT NULL DEFAULT '',
  `channel` varchar(128) NOT NULL DEFAULT '',
  `url` varchar(512) NOT NULL DEFAULT '',
  `favor` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `leader` (`leader`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance_list_player`
--

DROP TABLE IF EXISTS `instance_list_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_list_player` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `character_id` int(11) unsigned NOT NULL DEFAULT 0,
  `slot_id` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned DEFAULT 0,
  `charges` smallint(3) unsigned DEFAULT 0,
  `color` int(11) unsigned NOT NULL DEFAULT 0,
  `augment_one` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_two` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_three` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_four` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_five` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_six` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `instnodrop` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `ornament_icon` int(11) unsigned NOT NULL DEFAULT 0,
  `ornament_idfile` int(11) unsigned NOT NULL DEFAULT 0,
  `ornament_hero_model` int(11) NOT NULL DEFAULT 0,
  `guid` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`character_id`,`slot_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_snapshots`
--

DROP TABLE IF EXISTS `inventory_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_snapshots` (
  `time_index` int(11) unsigned NOT NULL DEFAULT 0,
  `charid` int(11) unsigned NOT NULL DEFAULT 0,
  `slotid` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `itemid` int(11) unsigned DEFAULT 0,
  `charges` smallint(3) unsigned DEFAULT 0,
  `color` int(11) unsigned NOT NULL DEFAULT 0,
  `augslot1` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augslot2` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augslot3` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augslot4` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augslot5` mediumint(7) unsigned DEFAULT 0,
  `augslot6` mediumint(7) NOT NULL DEFAULT 0,
  `instnodrop` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `ornamenticon` int(11) unsigned NOT NULL DEFAULT 0,
  `ornamentidfile` int(11) unsigned NOT NULL DEFAULT 0,
  `ornament_hero_model` int(11) NOT NULL DEFAULT 0,
  `guid` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`time_index`,`charid`,`slotid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keyring`
--

DROP TABLE IF EXISTS `keyring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyring` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_charid_itemid` (`char_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail` (
  `msgid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(10) unsigned NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `from` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(200) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `to` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`msgid`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petitions`
--

DROP TABLE IF EXISTS `petitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petitions` (
  `dib` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `petid` int(10) unsigned NOT NULL DEFAULT 0,
  `charname` varchar(32) NOT NULL DEFAULT '',
  `accountname` varchar(32) NOT NULL DEFAULT '',
  `lastgm` varchar(32) NOT NULL DEFAULT '',
  `petitiontext` text NOT NULL,
  `gmtext` text DEFAULT NULL,
  `zone` varchar(32) NOT NULL DEFAULT '',
  `urgency` int(11) NOT NULL DEFAULT 0,
  `charclass` int(11) NOT NULL DEFAULT 0,
  `charrace` int(11) NOT NULL DEFAULT 0,
  `charlevel` int(11) NOT NULL DEFAULT 0,
  `checkouts` int(11) NOT NULL DEFAULT 0,
  `unavailables` int(11) NOT NULL DEFAULT 0,
  `ischeckedout` tinyint(4) NOT NULL DEFAULT 0,
  `senttime` bigint(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dib`),
  KEY `petid` (`petid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_titlesets`
--

DROP TABLE IF EXISTS `player_titlesets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_titlesets` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(11) unsigned NOT NULL,
  `title_set` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `idx_char_id` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_globals`
--

DROP TABLE IF EXISTS `quest_globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_globals` (
  `charid` int(11) NOT NULL DEFAULT 0,
  `npcid` int(11) NOT NULL DEFAULT 0,
  `zoneid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(65) NOT NULL DEFAULT '',
  `value` varchar(128) NOT NULL DEFAULT '?',
  `expdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`charid`,`npcid`,`zoneid`,`name`),
  UNIQUE KEY `qname` (`name`,`charid`,`npcid`,`zoneid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sharedbank`
--

DROP TABLE IF EXISTS `sharedbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sharedbank` (
  `account_id` int(11) unsigned NOT NULL DEFAULT 0,
  `slot_id` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  `charges` smallint(3) unsigned NOT NULL DEFAULT 0,
  `color` int(11) unsigned NOT NULL DEFAULT 0,
  `augment_one` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_two` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_three` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_four` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_five` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `augment_six` mediumint(7) unsigned NOT NULL DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `ornament_icon` int(11) unsigned NOT NULL,
  `ornament_idfile` int(11) unsigned NOT NULL,
  `ornament_hero_model` int(11) NOT NULL,
  `guid` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`account_id`,`slot_id`),
  UNIQUE KEY `account` (`account_id`,`slot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_buckets`
--

DROP TABLE IF EXISTS `spell_buckets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_buckets` (
  `spell_id` int(10) unsigned NOT NULL,
  `bucket_name` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `bucket_value` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `bucket_comparison` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`spell_id`) USING BTREE,
  KEY `key_index` (`bucket_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_globals`
--

DROP TABLE IF EXISTS `spell_globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_globals` (
  `spellid` int(11) NOT NULL,
  `spell_name` varchar(64) NOT NULL DEFAULT '',
  `qglobal` varchar(65) NOT NULL DEFAULT '',
  `value` varchar(65) NOT NULL DEFAULT '',
  PRIMARY KEY (`spellid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timers`
--

DROP TABLE IF EXISTS `timers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timers` (
  `char_id` int(11) NOT NULL DEFAULT 0,
  `type` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `start` int(10) unsigned NOT NULL DEFAULT 0,
  `duration` int(10) unsigned NOT NULL DEFAULT 0,
  `enable` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trader`
--

DROP TABLE IF EXISTS `trader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trader` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  `aug_slot_1` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_2` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_3` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_4` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_5` int(10) unsigned NOT NULL DEFAULT 0,
  `aug_slot_6` int(10) unsigned NOT NULL DEFAULT 0,
  `item_sn` int(10) unsigned NOT NULL DEFAULT 0,
  `item_charges` int(11) NOT NULL DEFAULT 0,
  `item_cost` int(10) unsigned NOT NULL DEFAULT 0,
  `slot_id` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `char_entity_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_zone_id` int(11) unsigned NOT NULL DEFAULT 0,
  `char_zone_instance_id` int(11) DEFAULT 0,
  `active_transaction` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `listing_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index 2` (`char_id`,`slot_id`),
  KEY `idx_trader_item` (`item_id`,`item_cost`),
  KEY `idx_trader_char` (`char_id`,`char_zone_id`,`char_zone_instance_id`),
  KEY `idx_trader_item_sn` (`item_sn`),
  KEY `idx_trader_item_cost` (`item_cost`),
  KEY `idx_trader_active_transaction` (`active_transaction`),
  KEY `idx_trader_listing_date` (`listing_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trader_audit`
--

DROP TABLE IF EXISTS `trader_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trader_audit` (
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `seller` varchar(64) NOT NULL DEFAULT '',
  `buyer` varchar(64) NOT NULL DEFAULT '',
  `itemname` varchar(64) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `totalcost` int(11) NOT NULL DEFAULT 0,
  `trantype` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zone_flags`
--

DROP TABLE IF EXISTS `zone_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone_flags` (
  `charID` int(11) NOT NULL DEFAULT 0,
  `zoneID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`charID`,`zoneID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-28  3:00:04

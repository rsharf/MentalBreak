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
-- Table structure for table `adventure_members`
--

DROP TABLE IF EXISTS `adventure_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adventure_members` (
  `id` int(10) unsigned NOT NULL,
  `charid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`charid`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banned_ips`
--

DROP TABLE IF EXISTS `banned_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banned_ips` (
  `ip_address` varchar(32) NOT NULL,
  `notes` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bug_reports`
--

DROP TABLE IF EXISTS `bug_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bug_reports` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `zone` varchar(32) NOT NULL DEFAULT 'Unknown',
  `client_version_id` int(11) unsigned NOT NULL DEFAULT 0,
  `client_version_name` varchar(24) NOT NULL DEFAULT 'Unknown',
  `account_id` int(11) unsigned NOT NULL DEFAULT 0,
  `character_id` int(11) unsigned NOT NULL DEFAULT 0,
  `character_name` varchar(64) NOT NULL DEFAULT 'Unknown',
  `reporter_spoof` tinyint(1) NOT NULL DEFAULT 1,
  `category_id` int(11) unsigned NOT NULL DEFAULT 0,
  `category_name` varchar(64) NOT NULL DEFAULT 'Other',
  `reporter_name` varchar(64) NOT NULL DEFAULT 'Unknown',
  `ui_path` varchar(128) NOT NULL DEFAULT 'Unknown',
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `heading` int(11) unsigned NOT NULL DEFAULT 0,
  `time_played` int(11) unsigned NOT NULL DEFAULT 0,
  `target_id` int(11) unsigned NOT NULL DEFAULT 0,
  `target_name` varchar(64) NOT NULL DEFAULT 'Unknown',
  `optional_info_mask` int(11) unsigned NOT NULL DEFAULT 0,
  `_can_duplicate` tinyint(1) NOT NULL DEFAULT 0,
  `_crash_bug` tinyint(1) NOT NULL DEFAULT 0,
  `_target_info` tinyint(1) NOT NULL DEFAULT 0,
  `_character_flags` tinyint(1) NOT NULL DEFAULT 0,
  `_unknown_value` tinyint(1) NOT NULL DEFAULT 0,
  `bug_report` varchar(1024) NOT NULL DEFAULT '',
  `system_info` varchar(1024) NOT NULL DEFAULT '',
  `report_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `bug_status` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `last_review` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_reviewer` varchar(64) NOT NULL DEFAULT 'None',
  `reviewer_notes` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bugs`
--

DROP TABLE IF EXISTS `bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bugs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `zone` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `ui` varchar(128) NOT NULL,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `type` varchar(64) NOT NULL,
  `flag` tinyint(3) unsigned NOT NULL,
  `target` varchar(64) DEFAULT NULL,
  `bug` varchar(1024) NOT NULL,
  `date` date NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
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
-- Table structure for table `completed_shared_task_activity_state`
--

DROP TABLE IF EXISTS `completed_shared_task_activity_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_shared_task_activity_state` (
  `shared_task_id` bigint(20) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `done_count` int(11) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  PRIMARY KEY (`shared_task_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `completed_shared_task_members`
--

DROP TABLE IF EXISTS `completed_shared_task_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_shared_task_members` (
  `shared_task_id` bigint(20) NOT NULL,
  `character_id` bigint(20) NOT NULL,
  `is_leader` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`shared_task_id`,`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `completed_shared_tasks`
--

DROP TABLE IF EXISTS `completed_shared_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_shared_tasks` (
  `id` bigint(20) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `accepted_time` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `completion_time` datetime DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discord_webhooks`
--

DROP TABLE IF EXISTS `discord_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discord_webhooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `webhook_name` varchar(100) DEFAULT NULL,
  `webhook_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dynamic_zone_lockouts`
--

DROP TABLE IF EXISTS `dynamic_zone_lockouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_zone_lockouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_zone_id` int(10) unsigned NOT NULL,
  `event_name` varchar(256) NOT NULL,
  `expire_time` datetime NOT NULL DEFAULT current_timestamp(),
  `duration` int(10) unsigned NOT NULL DEFAULT 0,
  `from_expedition_uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dz_id_event_name` (`dynamic_zone_id`,`event_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dynamic_zone_members`
--

DROP TABLE IF EXISTS `dynamic_zone_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_zone_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `character_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dynamic_zone_id_character_id` (`dynamic_zone_id`,`character_id`),
  KEY `character_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dynamic_zones`
--

DROP TABLE IF EXISTS `dynamic_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(10) NOT NULL DEFAULT 0,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(36) CHARACTER SET latin1 NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `leader_id` int(10) unsigned NOT NULL DEFAULT 0,
  `min_players` int(10) unsigned NOT NULL DEFAULT 0,
  `max_players` int(10) unsigned NOT NULL DEFAULT 0,
  `dz_switch_id` int(11) NOT NULL DEFAULT 0,
  `compass_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `compass_x` float NOT NULL DEFAULT 0,
  `compass_y` float NOT NULL DEFAULT 0,
  `compass_z` float NOT NULL DEFAULT 0,
  `safe_return_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `safe_return_x` float NOT NULL DEFAULT 0,
  `safe_return_y` float NOT NULL DEFAULT 0,
  `safe_return_z` float NOT NULL DEFAULT 0,
  `safe_return_heading` float NOT NULL DEFAULT 0,
  `zone_in_x` float NOT NULL DEFAULT 0,
  `zone_in_y` float NOT NULL DEFAULT 0,
  `zone_in_z` float NOT NULL DEFAULT 0,
  `zone_in_heading` float NOT NULL DEFAULT 0,
  `has_zone_in` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_locked` tinyint(4) NOT NULL DEFAULT 0,
  `add_replay` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gm_ips`
--

DROP TABLE IF EXISTS `gm_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gm_ips` (
  `name` varchar(64) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  UNIQUE KEY `account_id` (`account_id`,`ip_address`),
  UNIQUE KEY `account_id_2` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_id`
--

DROP TABLE IF EXISTS `group_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_id` (
  `group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `character_id` int(11) unsigned NOT NULL DEFAULT 0,
  `bot_id` int(11) unsigned NOT NULL DEFAULT 0,
  `merc_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`,`character_id`,`bot_id`,`merc_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_leaders`
--

DROP TABLE IF EXISTS `group_leaders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_leaders` (
  `gid` int(4) NOT NULL DEFAULT 0,
  `leadername` varchar(64) NOT NULL DEFAULT '',
  `marknpc` varchar(64) NOT NULL DEFAULT '',
  `leadershipaa` tinyblob DEFAULT NULL,
  `maintank` varchar(64) NOT NULL DEFAULT '',
  `assist` varchar(64) NOT NULL DEFAULT '',
  `puller` varchar(64) NOT NULL DEFAULT '',
  `mentoree` varchar(64) NOT NULL,
  `mentor_percent` int(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance_list`
--

DROP TABLE IF EXISTS `instance_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` int(11) unsigned NOT NULL DEFAULT 0,
  `version` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `is_global` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `start_time` int(11) unsigned NOT NULL DEFAULT 0,
  `duration` int(11) unsigned NOT NULL DEFAULT 0,
  `expire_at` bigint(11) unsigned NOT NULL DEFAULT 0,
  `never_expires` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `notes` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `idx_expire_at` (`expire_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_exemptions`
--

DROP TABLE IF EXISTS `ip_exemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_exemptions` (
  `exemption_id` int(11) NOT NULL AUTO_INCREMENT,
  `exemption_ip` varchar(255) DEFAULT NULL,
  `exemption_amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`exemption_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lfguild`
--

DROP TABLE IF EXISTS `lfguild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lfguild` (
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL,
  `comment` varchar(256) NOT NULL,
  `fromlevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `tolevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `classes` int(10) unsigned NOT NULL DEFAULT 0,
  `aacount` int(10) unsigned NOT NULL DEFAULT 0,
  `timezone` int(10) unsigned NOT NULL DEFAULT 0,
  `timeposted` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merc_buffs`
--

DROP TABLE IF EXISTS `merc_buffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merc_buffs` (
  `MercBuffId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MercId` int(10) unsigned NOT NULL DEFAULT 0,
  `SpellId` int(10) unsigned NOT NULL DEFAULT 0,
  `CasterLevel` int(10) unsigned NOT NULL DEFAULT 0,
  `DurationFormula` int(10) unsigned NOT NULL DEFAULT 0,
  `TicsRemaining` int(11) NOT NULL DEFAULT 0,
  `PoisonCounters` int(11) unsigned NOT NULL DEFAULT 0,
  `DiseaseCounters` int(11) unsigned NOT NULL DEFAULT 0,
  `CurseCounters` int(11) unsigned NOT NULL DEFAULT 0,
  `CorruptionCounters` int(11) unsigned NOT NULL DEFAULT 0,
  `HitCount` int(10) unsigned NOT NULL DEFAULT 0,
  `MeleeRune` int(10) unsigned NOT NULL DEFAULT 0,
  `MagicRune` int(10) unsigned NOT NULL DEFAULT 0,
  `dot_rune` int(10) NOT NULL DEFAULT 0,
  `caston_x` int(10) NOT NULL DEFAULT 0,
  `Persistent` tinyint(1) NOT NULL DEFAULT 0,
  `caston_y` int(10) NOT NULL DEFAULT 0,
  `caston_z` int(10) NOT NULL DEFAULT 0,
  `ExtraDIChance` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`MercBuffId`),
  KEY `FK_mercbuff_1` (`MercId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchantlist_temp`
--

DROP TABLE IF EXISTS `merchantlist_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchantlist_temp` (
  `npcid` int(10) unsigned NOT NULL DEFAULT 0,
  `slot` int(11) unsigned NOT NULL DEFAULT 0,
  `zone_id` int(11) NOT NULL DEFAULT 0,
  `instance_id` int(11) NOT NULL DEFAULT 0,
  `itemid` int(10) unsigned NOT NULL DEFAULT 0,
  `charges` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`npcid`,`slot`,`zone_id`,`instance_id`),
  KEY `npcid_2` (`npcid`,`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mercs`
--

DROP TABLE IF EXISTS `mercs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mercs` (
  `MercID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OwnerCharacterID` int(10) unsigned NOT NULL,
  `Slot` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(64) NOT NULL,
  `TemplateID` int(10) unsigned NOT NULL DEFAULT 0,
  `SuspendedTime` int(11) unsigned NOT NULL DEFAULT 0,
  `IsSuspended` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `TimerRemaining` int(11) unsigned NOT NULL DEFAULT 0,
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MercSize` float NOT NULL DEFAULT 5,
  `StanceID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `HP` int(11) unsigned NOT NULL DEFAULT 0,
  `Mana` int(11) unsigned NOT NULL DEFAULT 0,
  `Endurance` int(11) unsigned NOT NULL DEFAULT 0,
  `Face` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinHairStyle` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinHairColor` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinEyeColor` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinEyeColor2` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinBeardColor` int(10) unsigned NOT NULL DEFAULT 1,
  `LuclinBeard` int(10) unsigned NOT NULL DEFAULT 0,
  `DrakkinHeritage` int(10) unsigned NOT NULL DEFAULT 0,
  `DrakkinTattoo` int(10) unsigned NOT NULL DEFAULT 0,
  `DrakkinDetails` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`MercID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_contents`
--

DROP TABLE IF EXISTS `object_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_contents` (
  `zoneid` int(11) unsigned NOT NULL DEFAULT 0,
  `parentid` int(11) unsigned NOT NULL DEFAULT 0,
  `bagidx` int(11) unsigned NOT NULL DEFAULT 0,
  `itemid` int(11) unsigned NOT NULL DEFAULT 0,
  `charges` smallint(3) NOT NULL DEFAULT 0,
  `droptime` datetime NOT NULL DEFAULT current_timestamp(),
  `augslot1` mediumint(7) unsigned DEFAULT 0,
  `augslot2` mediumint(7) unsigned DEFAULT 0,
  `augslot3` mediumint(7) unsigned DEFAULT 0,
  `augslot4` mediumint(7) unsigned DEFAULT 0,
  `augslot5` mediumint(7) unsigned DEFAULT 0,
  `augslot6` mediumint(7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`parentid`,`bagidx`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raid_details`
--

DROP TABLE IF EXISTS `raid_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raid_details` (
  `raidid` int(4) NOT NULL DEFAULT 0,
  `loottype` int(4) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `motd` varchar(1024) DEFAULT NULL,
  `marked_npc_1_entity_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_1_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_1_instance_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_2_entity_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_2_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_2_instance_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_3_entity_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_3_zone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `marked_npc_3_instance_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`raidid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raid_leaders`
--

DROP TABLE IF EXISTS `raid_leaders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raid_leaders` (
  `gid` int(4) unsigned NOT NULL,
  `rid` int(4) unsigned NOT NULL,
  `marknpc` varchar(64) NOT NULL,
  `maintank` varchar(64) NOT NULL,
  `assist` varchar(64) NOT NULL,
  `puller` varchar(64) NOT NULL,
  `leadershipaa` tinyblob NOT NULL,
  `mentoree` varchar(64) NOT NULL,
  `mentor_percent` int(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raid_members`
--

DROP TABLE IF EXISTS `raid_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raid_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `raidid` int(4) NOT NULL DEFAULT 0,
  `charid` int(4) NOT NULL DEFAULT 0,
  `bot_id` int(4) NOT NULL DEFAULT 0,
  `groupid` int(4) unsigned NOT NULL DEFAULT 0,
  `_class` tinyint(4) NOT NULL DEFAULT 0,
  `level` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `isgroupleader` tinyint(1) NOT NULL DEFAULT 0,
  `israidleader` tinyint(1) NOT NULL DEFAULT 0,
  `islooter` tinyint(1) NOT NULL DEFAULT 0,
  `is_marker` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_assister` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `note` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `reported` varchar(64) DEFAULT NULL,
  `reported_text` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `respawn_times`
--

DROP TABLE IF EXISTS `respawn_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respawn_times` (
  `id` int(11) NOT NULL DEFAULT 0,
  `start` int(11) NOT NULL DEFAULT 0,
  `duration` int(11) NOT NULL DEFAULT 0,
  `expire_at` int(11) unsigned DEFAULT 0,
  `instance_id` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`instance_id`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_expire_at` (`expire_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saylink`
--

DROP TABLE IF EXISTS `saylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saylink` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `phrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `phrase_index` (`phrase`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_scheduled_events`
--

DROP TABLE IF EXISTS `server_scheduled_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_scheduled_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `event_type` varchar(100) DEFAULT NULL,
  `event_data` text DEFAULT NULL,
  `minute_start` int(11) DEFAULT 0,
  `hour_start` int(11) DEFAULT 0,
  `day_start` int(11) DEFAULT 0,
  `month_start` int(11) DEFAULT 0,
  `year_start` int(11) DEFAULT 0,
  `minute_end` int(11) DEFAULT 0,
  `hour_end` int(11) DEFAULT 0,
  `day_end` int(11) DEFAULT 0,
  `month_end` int(11) DEFAULT 0,
  `year_end` int(11) DEFAULT 0,
  `cron_expression` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spawn2_disabled`
--

DROP TABLE IF EXISTS `spawn2_disabled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spawn2_disabled` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `spawn2_id` int(11) DEFAULT NULL,
  `instance_id` int(11) DEFAULT 0,
  `disabled` smallint(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spawn2_id` (`spawn2_id`,`instance_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_aa_purchase`
--

DROP TABLE IF EXISTS `player_event_aa_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_aa_purchase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `aa_ability_id` int(11) DEFAULT 0,
  `cost` int(11) DEFAULT 0,
  `previous_id` int(11) DEFAULT 0,
  `next_id` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_killed_npc`
--

DROP TABLE IF EXISTS `player_event_killed_npc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_killed_npc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `npc_name` varchar(64) DEFAULT NULL,
  `combat_time_seconds` int(10) unsigned DEFAULT 0,
  `total_damage_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `total_heal_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npc_id` (`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_killed_named_npc`
--

DROP TABLE IF EXISTS `player_event_killed_named_npc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_killed_named_npc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `npc_name` varchar(64) DEFAULT NULL,
  `combat_time_seconds` int(10) unsigned DEFAULT 0,
  `total_damage_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `total_heal_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npc_id` (`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_killed_raid_npc`
--

DROP TABLE IF EXISTS `player_event_killed_raid_npc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_killed_raid_npc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `npc_name` varchar(64) DEFAULT NULL,
  `combat_time_seconds` int(10) unsigned DEFAULT 0,
  `total_damage_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `total_heal_per_second_taken` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npc_id` (`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_log_settings`
--

DROP TABLE IF EXISTS `player_event_log_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_log_settings` (
  `id` bigint(20) NOT NULL,
  `event_name` varchar(100) DEFAULT NULL,
  `event_enabled` tinyint(1) DEFAULT NULL,
  `retention_days` int(11) DEFAULT 0,
  `discord_webhook_id` int(11) DEFAULT 0,
  `etl_enabled` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_logs`
--

DROP TABLE IF EXISTS `player_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `character_id` bigint(20) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `instance_id` int(11) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `heading` float DEFAULT NULL,
  `event_type_id` int(11) DEFAULT NULL,
  `event_type_name` varchar(255) DEFAULT NULL,
  `event_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`event_data`)),
  `etl_table_id` bigint(20) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_created_at` (`event_type_id`,`created_at`),
  KEY `zone_id` (`zone_id`),
  KEY `character_id` (`character_id`,`zone_id`) USING BTREE,
  KEY `created_at` (`created_at`),
  KEY `idx_event_type_char_id` (`event_type_id`,`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_loot_items`
--

DROP TABLE IF EXISTS `player_event_loot_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_loot_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT NULL,
  `item_name` varchar(64) DEFAULT NULL,
  `charges` int(11) DEFAULT NULL,
  `augment_1_id` int(10) unsigned DEFAULT 0,
  `augment_2_id` int(10) unsigned DEFAULT 0,
  `augment_3_id` int(10) unsigned DEFAULT 0,
  `augment_4_id` int(10) unsigned DEFAULT 0,
  `augment_5_id` int(10) unsigned DEFAULT 0,
  `augment_6_id` int(10) unsigned DEFAULT 0,
  `npc_id` int(10) unsigned DEFAULT NULL,
  `corpse_name` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `item_id_npc_id` (`item_id`,`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_merchant_purchase`
--

DROP TABLE IF EXISTS `player_event_merchant_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_merchant_purchase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `merchant_name` varchar(64) DEFAULT NULL,
  `merchant_type` int(10) unsigned DEFAULT 0,
  `item_id` int(10) unsigned DEFAULT 0,
  `item_name` varchar(64) DEFAULT NULL,
  `charges` int(11) DEFAULT 0,
  `cost` int(10) unsigned DEFAULT 0,
  `alternate_currency_id` int(10) unsigned DEFAULT 0,
  `player_money_balance` bigint(20) unsigned DEFAULT 0,
  `player_currency_balance` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `item_id_npc_id` (`item_id`,`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_merchant_sell`
--

DROP TABLE IF EXISTS `player_event_merchant_sell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_merchant_sell` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `merchant_name` varchar(64) DEFAULT NULL,
  `merchant_type` int(10) unsigned DEFAULT 0,
  `item_id` int(10) unsigned DEFAULT 0,
  `item_name` varchar(64) DEFAULT NULL,
  `charges` int(11) DEFAULT 0,
  `cost` int(10) unsigned DEFAULT 0,
  `alternate_currency_id` int(10) unsigned DEFAULT 0,
  `player_money_balance` bigint(20) unsigned DEFAULT 0,
  `player_currency_balance` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `item_id_npc_id` (`item_id`,`npc_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_npc_handin`
--

DROP TABLE IF EXISTS `player_event_npc_handin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_npc_handin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) unsigned DEFAULT 0,
  `npc_name` varchar(64) DEFAULT NULL,
  `handin_copper` bigint(20) unsigned DEFAULT 0,
  `handin_silver` bigint(20) unsigned DEFAULT 0,
  `handin_gold` bigint(20) unsigned DEFAULT 0,
  `handin_platinum` bigint(20) unsigned DEFAULT 0,
  `return_copper` bigint(20) unsigned DEFAULT 0,
  `return_silver` bigint(20) unsigned DEFAULT 0,
  `return_gold` bigint(20) unsigned DEFAULT 0,
  `return_platinum` bigint(20) unsigned DEFAULT 0,
  `is_quest_handin` tinyint(3) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npc_id_is_quest_handin` (`npc_id`,`is_quest_handin`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_npc_handin_entries`
--

DROP TABLE IF EXISTS `player_event_npc_handin_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_npc_handin_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `player_event_npc_handin_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned DEFAULT NULL,
  `item_id` int(10) unsigned NOT NULL DEFAULT 0,
  `charges` int(11) NOT NULL DEFAULT 0,
  `evolve_level` int(10) unsigned NOT NULL DEFAULT 0,
  `evolve_amount` bigint(20) unsigned NOT NULL DEFAULT 0,
  `augment_1_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_2_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_3_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_4_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_5_id` int(10) unsigned NOT NULL DEFAULT 0,
  `augment_6_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_item_id` (`type`,`item_id`) USING BTREE,
  KEY `player_event_npc_handin_id` (`player_event_npc_handin_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_speech`
--

DROP TABLE IF EXISTS `player_event_speech`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_speech` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `to_char_id` varchar(64) DEFAULT NULL,
  `from_char_id` varchar(64) DEFAULT NULL,
  `guild_id` int(10) unsigned DEFAULT 0,
  `type` int(10) unsigned DEFAULT 0,
  `min_status` int(10) unsigned DEFAULT 0,
  `message` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `to_char_id_from_char_id` (`to_char_id`,`from_char_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_trade`
--

DROP TABLE IF EXISTS `player_event_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_trade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `char1_id` int(10) unsigned DEFAULT 0,
  `char2_id` int(10) unsigned DEFAULT 0,
  `char1_copper` bigint(20) unsigned DEFAULT 0,
  `char1_silver` bigint(20) unsigned DEFAULT 0,
  `char1_gold` bigint(20) unsigned DEFAULT 0,
  `char1_platinum` bigint(20) unsigned DEFAULT 0,
  `char2_copper` bigint(20) unsigned DEFAULT 0,
  `char2_silver` bigint(20) unsigned DEFAULT 0,
  `char2_gold` bigint(20) unsigned DEFAULT 0,
  `char2_platinum` bigint(20) unsigned DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `char1_id_char2_id` (`char1_id`,`char2_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_event_trade_entries`
--

DROP TABLE IF EXISTS `player_event_trade_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_event_trade_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `player_event_trade_id` bigint(20) unsigned DEFAULT 0,
  `char_id` int(10) unsigned DEFAULT 0,
  `slot` smallint(6) DEFAULT 0,
  `item_id` int(10) unsigned DEFAULT 0,
  `charges` smallint(6) DEFAULT 0,
  `augment_1_id` int(10) unsigned DEFAULT 0,
  `augment_2_id` int(10) unsigned DEFAULT 0,
  `augment_3_id` int(10) unsigned DEFAULT 0,
  `augment_4_id` int(10) unsigned DEFAULT 0,
  `augment_5_id` int(10) unsigned DEFAULT 0,
  `augment_6_id` int(10) unsigned DEFAULT 0,
  `in_bag` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `player_event_trade_id` (`player_event_trade_id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_task_activity_state`
--

DROP TABLE IF EXISTS `shared_task_activity_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_task_activity_state` (
  `shared_task_id` bigint(20) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `done_count` int(11) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  PRIMARY KEY (`shared_task_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_task_dynamic_zones`
--

DROP TABLE IF EXISTS `shared_task_dynamic_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_task_dynamic_zones` (
  `shared_task_id` bigint(20) NOT NULL,
  `dynamic_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`shared_task_id`,`dynamic_zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_task_members`
--

DROP TABLE IF EXISTS `shared_task_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_task_members` (
  `shared_task_id` bigint(20) NOT NULL,
  `character_id` bigint(20) NOT NULL,
  `is_leader` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`shared_task_id`,`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_tasks`
--

DROP TABLE IF EXISTS `shared_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `accepted_time` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `completion_time` datetime DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zone_state_spawns`
--

DROP TABLE IF EXISTS `zone_state_spawns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone_state_spawns` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) unsigned DEFAULT NULL,
  `instance_id` int(11) unsigned DEFAULT NULL,
  `is_corpse` tinyint(11) DEFAULT 0,
  `is_zone` tinyint(11) DEFAULT 0,
  `decay_in_seconds` int(11) DEFAULT 0,
  `npc_id` int(10) unsigned DEFAULT NULL,
  `spawn2_id` int(10) unsigned NOT NULL,
  `spawngroup_id` int(10) unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` float NOT NULL,
  `respawn_time` int(10) unsigned NOT NULL,
  `variance` int(10) unsigned NOT NULL,
  `grid` int(10) unsigned DEFAULT 0,
  `current_waypoint` int(11) DEFAULT 0,
  `path_when_zone_idle` smallint(6) DEFAULT 0,
  `condition_id` smallint(5) unsigned DEFAULT 0,
  `condition_min_value` smallint(6) DEFAULT 0,
  `enabled` smallint(6) DEFAULT 1,
  `anim` smallint(5) unsigned DEFAULT 0,
  `loot_data` text DEFAULT NULL,
  `entity_variables` text DEFAULT NULL,
  `buffs` text DEFAULT NULL,
  `hp` bigint(20) DEFAULT 0,
  `mana` bigint(20) DEFAULT 0,
  `endurance` bigint(20) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_zone_instance` (`zone_id`,`instance_id`),
  KEY `idx_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `instance_list`
--
-- WHERE:  instance_list.is_global > 0 and instance_list.never_expires > 0

LOCK TABLES `instance_list` WRITE;
/*!40000 ALTER TABLE `instance_list` DISABLE KEYS */;
INSERT INTO `instance_list` VALUES
(1,25,1,1,0,0,0,1,'Nektulos DoDH'),
(2,25,2,1,0,0,0,1,'Nektulos Unused'),
(3,151,1,1,0,0,0,1,'Dragons of Norrath Bazaar (version 2)'),
(4,114,1,1,0,0,0,1,'Skyshrine Sleeper ?'),
(5,27,1,1,0,0,0,1,'Lavastorm - Dragons of Norrath'),
(6,18,1,1,0,0,0,1,'Paw V2 - Dragons of Norrath - Jan 26, 2005'),
(7,107,1,1,0,0,0,1,'Nurga V2 - LDON - July 10, 2003'),
(8,81,1,1,0,0,0,1,'Droga V2 - LDON - July 10, 2003'),
(9,163,1,1,0,0,0,1,'Griegsend V2 - LDON - Aug 26 2003'),
(10,90,1,1,0,0,0,1,'Citymist V2 - LDON - Aug 26 2003'),
(11,125,1,1,0,0,0,1,'Sirens V2 - LDON - Aug 26 2003');
/*!40000 ALTER TABLE `instance_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-28  3:00:06

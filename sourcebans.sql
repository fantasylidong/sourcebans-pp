-- Adminer 4.8.1 MySQL 5.7.37 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `sb_admins`;
CREATE TABLE `sb_admins` (
  `aid` int(6) NOT NULL AUTO_INCREMENT,
  `user` varchar(64) NOT NULL,
  `authid` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(128) NOT NULL,
  `gid` int(6) NOT NULL,
  `email` varchar(128) NOT NULL,
  `validate` varchar(128) DEFAULT NULL,
  `extraflags` int(10) NOT NULL,
  `immunity` int(10) NOT NULL DEFAULT '0',
  `srv_group` varchar(128) DEFAULT NULL,
  `srv_flags` varchar(64) DEFAULT NULL,
  `srv_password` varchar(128) DEFAULT NULL,
  `lastvisit` int(11) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_admins` (`aid`, `user`, `authid`, `password`, `gid`, `email`, `validate`, `extraflags`, `immunity`, `srv_group`, `srv_flags`, `srv_password`, `lastvisit`) VALUES
(1,	'morzlee',	'76561198203126935',	'$2y$10$b/v1G9/bwhCYv3hgv8bFieX5D4qITVpCrRP74Y6XM72QH5l/ht/rG',	-1,	'lee@trygek.com',	NULL,	16777216,	100,	NULL,	NULL,	NULL,	1645026419),
(5,	'跌跌撞撞',	'STEAM_0:1:105875074',	'$2y$10$6BUgUhNyr.Rcd4gb3KWflerb0ooHLVZ4MCbIiU6ljcucbe1F9Okeu',	0,	'',	NULL,	0,	0,	'normal admin',	'abcdgjk',	'',	NULL),
(6,	'鉴情师',	'STEAM_0:1:174857914',	'$2y$10$nWVrGw9iiL1ltHaQAPDN5OhxnLljj3omJmDsqWabDpLzFG7zzuaDa',	-1,	'tet1@qq.com',	NULL,	0,	0,	'normal admin',	'',	'',	NULL),
(7,	'萝卜丝',	'STEAM_0:0:93111423',	'$2y$10$sZJEYsn66PCmImWqpNpdb.sZv4lceViMYioc1Pzkv.2DyXFUBEGHe',	-1,	'12312',	NULL,	0,	0,	'normal admin',	'',	'',	NULL),
(8,	'izaya',	'STEAM_0:1:70145730',	'$2y$10$4ZSYW/Dqj7x0AsrjffugguCdZ6MbwzuIUhU06DmMGbBV6BzVfqX2.',	-1,	'123',	NULL,	0,	0,	'normal admin',	'',	'',	NULL);

DROP TABLE IF EXISTS `sb_admins_servers_groups`;
CREATE TABLE `sb_admins_servers_groups` (
  `admin_id` int(10) NOT NULL,
  `group_id` int(10) NOT NULL,
  `srv_group_id` int(10) NOT NULL,
  `server_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_admins_servers_groups` (`admin_id`, `group_id`, `srv_group_id`, `server_id`) VALUES
(5,	1,	-1,	2),
(5,	1,	-1,	3),
(5,	1,	-1,	4),
(5,	1,	-1,	5),
(5,	1,	-1,	6),
(5,	1,	-1,	7),
(5,	1,	-1,	8),
(5,	1,	-1,	9),
(6,	1,	-1,	2),
(6,	1,	-1,	3),
(6,	1,	-1,	4),
(6,	1,	-1,	5),
(6,	1,	-1,	6),
(6,	1,	-1,	7),
(6,	1,	-1,	8),
(6,	1,	-1,	9),
(7,	1,	-1,	2),
(7,	1,	-1,	3),
(7,	1,	-1,	4),
(7,	1,	-1,	5),
(7,	1,	-1,	6),
(7,	1,	-1,	7),
(7,	1,	-1,	8),
(7,	1,	-1,	9),
(8,	1,	-1,	2),
(8,	1,	-1,	3),
(8,	1,	-1,	4),
(8,	1,	-1,	5),
(8,	1,	-1,	6),
(8,	1,	-1,	7),
(8,	1,	-1,	8),
(8,	1,	-1,	9),
(8,	1,	-1,	10),
(8,	1,	-1,	11),
(8,	1,	-1,	12);

DROP TABLE IF EXISTS `sb_banlog`;
CREATE TABLE `sb_banlog` (
  `sid` int(6) NOT NULL,
  `time` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `bid` int(6) NOT NULL,
  PRIMARY KEY (`sid`,`time`,`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_banlog` (`sid`, `time`, `name`, `bid`) VALUES
(2,	1644999148,	'Aya',	6),
(2,	1645002043,	'Aya',	6),
(2,	1645005563,	'沙包人',	7),
(2,	1645005834,	'沙包人',	7),
(3,	1644998833,	'Aya',	6);

DROP TABLE IF EXISTS `sb_bans`;
CREATE TABLE `sb_bans` (
  `bid` int(6) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) DEFAULT NULL,
  `authid` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT 'unnamed',
  `created` int(11) NOT NULL DEFAULT '0',
  `ends` int(11) NOT NULL DEFAULT '0',
  `length` int(10) NOT NULL DEFAULT '0',
  `reason` text NOT NULL,
  `aid` int(6) NOT NULL DEFAULT '0',
  `adminIp` varchar(32) NOT NULL DEFAULT '',
  `sid` int(6) NOT NULL DEFAULT '0',
  `country` varchar(4) DEFAULT NULL,
  `RemovedBy` int(8) DEFAULT NULL,
  `RemoveType` varchar(3) DEFAULT NULL,
  `RemovedOn` int(10) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `ureason` text,
  PRIMARY KEY (`bid`),
  KEY `sid` (`sid`),
  KEY `type_authid` (`type`,`authid`),
  KEY `type_ip` (`type`,`ip`),
  FULLTEXT KEY `reason` (`reason`),
  FULLTEXT KEY `authid_2` (`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_bans` (`bid`, `ip`, `authid`, `name`, `created`, `ends`, `length`, `reason`, `aid`, `adminIp`, `sid`, `country`, `RemovedBy`, `RemoveType`, `RemovedOn`, `type`, `ureason`) VALUES
(2,	'172.17.0.1',	'STEAM_1:1:603635518',	'239196695',	1642825066,	1642825066,	0,	'General Exploit of Game/Map/Server',	0,	'172.17.0.1',	27,	' ',	NULL,	NULL,	NULL,	0,	NULL),
(3,	'172.17.0.1',	'STEAM_1:1:619799834',	'1308633717',	1642825148,	1642826948,	1800,	'General Exploit of Game/Map/Server',	0,	'172.17.0.1',	27,	' ',	0,	'E',	1642866632,	0,	NULL),
(5,	'',	'STEAM_0:1:236332239',	'北森深鹿',	1644976459,	1644976459,	0,	'Aimbot',	1,	'10.0.0.5',	0,	NULL,	NULL,	NULL,	NULL,	0,	NULL),
(6,	'171.213.52.6',	'STEAM_1:0:432158669',	'Aya',	1644997055,	1644997055,	0,	'[Little Anti-Cheat 1.7.1] Aimbot Detected',	0,	'192.168.16.4',	2,	' ',	1,	'U',	1645002920,	0,	'Mistakes'),
(7,	'120.230.59.146',	'STEAM_1:0:207406212',	'沙包人',	1645005535,	1647597535,	2592000,	'[Little Anti-Cheat 1.7.1] Bhop Detected',	0,	'192.168.16.4',	2,	' ',	1,	'U',	1645068328,	0,	'第一次解除ban'),
(8,	'223.74.230.28',	'STEAM_1:1:615878492',	'赢不了摆烂了',	1645011149,	1647603149,	2592000,	'[Little Anti-Cheat 1.7.1] Bhop Detected',	0,	'172.16.16.4',	2,	' ',	1,	'U',	1645068319,	0,	'第一次解除ban'),
(9,	'49.70.91.106',	'STEAM_1:1:196631521',	'たぶん',	1645016446,	1645016446,	0,	'[Little Anti-Cheat 1.7.1] Aimbot Detected',	0,	'192.168.16.4',	2,	' ',	NULL,	NULL,	NULL,	0,	NULL),
(10,	'222.212.29.197',	'STEAM_1:1:452360485',	'麦氏环企鹅',	1645033015,	1647625015,	2592000,	'[Little Anti-Cheat 1.7.1] Bhop Detected',	0,	'10.0.0.2',	2,	' ',	1,	'U',	1645068311,	0,	'第一次解除ban'),
(11,	'',	'STEAM_0:1:639850215',	'tt',	1645073568,	1645073568,	0,	'Aimbot',	1,	'10.0.0.5',	0,	NULL,	NULL,	NULL,	NULL,	0,	NULL);

DROP TABLE IF EXISTS `sb_comments`;
CREATE TABLE `sb_comments` (
  `cid` int(6) NOT NULL AUTO_INCREMENT,
  `bid` int(6) NOT NULL,
  `type` varchar(1) NOT NULL,
  `aid` int(6) NOT NULL,
  `commenttxt` longtext NOT NULL,
  `added` int(11) NOT NULL,
  `editaid` int(6) DEFAULT NULL,
  `edittime` int(11) DEFAULT NULL,
  KEY `cid` (`cid`),
  FULLTEXT KEY `commenttxt` (`commenttxt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_comms`;
CREATE TABLE `sb_comms` (
  `bid` int(6) NOT NULL AUTO_INCREMENT,
  `authid` varchar(64) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'unnamed',
  `created` int(11) NOT NULL DEFAULT '0',
  `ends` int(11) NOT NULL DEFAULT '0',
  `length` int(10) NOT NULL DEFAULT '0',
  `reason` text NOT NULL,
  `aid` int(6) NOT NULL DEFAULT '0',
  `adminIp` varchar(32) NOT NULL DEFAULT '',
  `sid` int(6) NOT NULL DEFAULT '0',
  `RemovedBy` int(8) DEFAULT NULL,
  `RemoveType` varchar(3) DEFAULT NULL,
  `RemovedOn` int(11) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1 - Mute, 2 - Gag',
  `ureason` text,
  PRIMARY KEY (`bid`),
  KEY `sid` (`sid`),
  KEY `type` (`type`),
  KEY `RemoveType` (`RemoveType`),
  KEY `authid` (`authid`),
  KEY `created` (`created`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_demos`;
CREATE TABLE `sb_demos` (
  `demid` int(6) NOT NULL,
  `demtype` varchar(1) NOT NULL,
  `filename` varchar(128) NOT NULL,
  `origname` varchar(128) NOT NULL,
  PRIMARY KEY (`demid`,`demtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_groups`;
CREATE TABLE `sb_groups` (
  `gid` int(6) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT 'unnamed',
  `flags` int(10) NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_log`;
CREATE TABLE `sb_log` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('m','w','e') NOT NULL,
  `title` varchar(512) NOT NULL,
  `message` text NOT NULL,
  `function` text NOT NULL,
  `query` text NOT NULL,
  `aid` int(11) NOT NULL,
  `host` text NOT NULL,
  `created` int(11) NOT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_log` (`lid`, `type`, `title`, `message`, `function`, `query`, `aid`, `host`, `created`) VALUES
(1,	'm',	'Server Added',	'Server (home.trygek.com:2339) has been added.',	'',	'',	1,	'172.17.0.1',	1642699478),
(2,	'm',	'Server Added',	'Server (home.trygek.com:2333) has been added.',	'',	'',	1,	'172.17.0.1',	1642699553),
(3,	'm',	'Server Added',	'Server (home.trygek.com:2334) has been added.',	'',	'',	1,	'172.17.0.1',	1642700572),
(4,	'm',	'Server Added',	'Server (home.trygek.com:2335) has been added.',	'',	'',	1,	'172.17.0.1',	1642700598),
(5,	'm',	'Server Added',	'Server (home.trygek.com:2336) has been added.',	'',	'',	1,	'172.17.0.1',	1642700621),
(6,	'm',	'Server Added',	'Server (home.trygek.com:2337) has been added.',	'',	'',	1,	'172.17.0.1',	1642700663),
(7,	'm',	'Server Added',	'Server (home.trygek.com:2338) has been added.',	'',	'',	1,	'172.17.0.1',	1642700686),
(8,	'm',	'Server Deleted',	'Server (home.trygek.com:2339) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642700693),
(9,	'm',	'Server Added',	'Server (home.trygek.com:2339) has been added.',	'',	'',	1,	'172.17.0.1',	1642700710),
(10,	'm',	'Server Added',	'Server (home.trygek.com:2340) has been added.',	'',	'',	1,	'172.17.0.1',	1642700732),
(11,	'm',	'Server Added',	'Server (home.trygek.com:2332) has been added.',	'',	'',	1,	'172.17.0.1',	1642702033),
(12,	'm',	'Server Added',	'Server (home.trygek.com:2331) has been added.',	'',	'',	1,	'172.17.0.1',	1642702072),
(13,	'm',	'Ban Added',	'Ban against (STEAM_0:1:121430603) has been added. Reason: Aimbot; Length: 1',	'',	'',	1,	'172.17.0.1',	1642702126),
(14,	'm',	'Server Added',	'Server (home.trygek.com:2330) has been added.',	'',	'',	1,	'172.17.0.1',	1642761037),
(15,	'm',	'Server Deleted',	'Server (172.17.0.7:2335) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642779595),
(16,	'm',	'Server Deleted',	'Server (172.17.0.5:2333) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642779601),
(17,	'm',	'Server Deleted',	'Server (172.17.0.5:2333) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642781003),
(18,	'm',	'Server Deleted',	'Server (172.17.0.12:2334) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642781008),
(19,	'm',	'Player kicked',	'morzlee kicked player 沁汐 (STEAM_1:1:597571429)',	'',	'',	1,	'172.17.0.1',	1642784174),
(20,	'm',	'Server Deleted',	'Server (172.17.0.7:2335) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813502),
(21,	'm',	'Server Deleted',	'Server (172.17.0.8:2334) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813506),
(22,	'm',	'Server Deleted',	'Server (172.17.0.2:2333) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813509),
(23,	'm',	'Server Deleted',	'Server (172.17.0.8:2333) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813513),
(24,	'm',	'Server Deleted',	'Server (172.17.0.12:2334) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813517),
(25,	'm',	'Server Deleted',	'Server (172.17.0.4:2335) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642813521),
(26,	'm',	'Server Deleted',	'Server (172.17.0.12:2340) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642828963),
(27,	'm',	'Server Deleted',	'Server (172.17.0.11:2339) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642828967),
(28,	'm',	'Server Deleted',	'Server (172.17.0.10:2338) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642828970),
(29,	'm',	'Server Deleted',	'Server (172.17.0.9:2337) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642828974),
(30,	'm',	'Server Deleted',	'Server (172.17.0.8:2336) has been deleted.',	'',	'',	1,	'172.17.0.1',	1642828978),
(31,	'm',	'Admin added',	'Admin (跌跌撞撞) has been added.',	'',	'',	1,	'172.17.0.1',	1642943506),
(32,	'm',	'Ban Deleted',	'Ban ⎛⎝东⎠⎞ (STEAM_0:1:121430603) has been deleted.',	'',	'p=banlist&a=delete&id=1&key=a8a8b47ea9e98790826cea87c46cdb4e',	1,	'172.17.0.1',	1642944611),
(33,	'm',	'Block Deleted',	'Block ⎛⎝东⎠⎞ (STEAM_1:1:121430603) has been deleted.',	'',	'p=commslist&a=delete&id=1&key=a8a8b47ea9e98790826cea87c46cdb4e',	1,	'172.17.0.1',	1642944621),
(34,	'm',	'Group Created',	'A new group was created (normal admin).',	'',	'',	1,	'172.17.0.1',	1643002960),
(35,	'm',	'Admin&#39;s Groups Updated',	'Admin (跌跌撞撞) groups has been updated.',	'',	'p=admin&c=admins&o=editgroup&id=5',	1,	'172.17.0.1',	1643002983),
(36,	'e',	'Rcon Error [ServerID: 5]',	'Can&#39;t connect to RCON server: Connection timed out',	'',	'',	1,	'172.17.0.1',	1643002984),
(37,	'e',	'Rcon Error [ServerID: 8]',	'Can&#39;t connect to RCON server: Connection timed out',	'',	'',	1,	'172.17.0.1',	1643002985),
(38,	'm',	'Permissions Changed',	'Permissions have been changed for (跌跌撞撞)',	'',	'',	1,	'172.17.0.1',	1643003006),
(39,	'e',	'Rcon Error [ServerID: 5]',	'Can&#39;t connect to RCON server: Connection timed out',	'',	'',	1,	'172.17.0.1',	1643003007),
(40,	'e',	'Rcon Error [ServerID: 8]',	'Can&#39;t connect to RCON server: Connection timed out',	'',	'',	1,	'172.17.0.1',	1643003008),
(41,	'm',	'Admin added',	'Admin (鉴情师) has been added.',	'',	'',	1,	'10.0.0.5',	1643211939),
(42,	'm',	'Group Updated',	'Group (normal admin) has been updated.',	'',	'',	1,	'10.0.0.5',	1643212280),
(43,	'e',	'Rcon Error [ServerID: 12]',	'Can&#39;t connect to RCON server: Connection timed out',	'',	'',	1,	'10.0.0.5',	1643212281),
(44,	'm',	'Admin added',	'Admin (萝卜丝) has been added.',	'',	'',	1,	'10.0.0.5',	1643213282),
(45,	'm',	'Ban Added',	'Ban against (STEAM_0:0:97704553) has been added. Reason: Aimbot; Length: 0',	'',	'',	1,	'10.0.0.5',	1643378255),
(46,	'e',	'Rcon Error [ServerID: 2]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(47,	'e',	'Rcon Error [ServerID: 8]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(48,	'e',	'Rcon Error [ServerID: 3]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(49,	'e',	'Rcon Error [ServerID: 9]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(50,	'e',	'Rcon Error [ServerID: 11]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(51,	'e',	'Rcon Error [ServerID: 10]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(52,	'e',	'Rcon Error [ServerID: 6]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(53,	'e',	'Rcon Error [ServerID: 7]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(54,	'e',	'Rcon Error [ServerID: 5]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(55,	'e',	'Rcon Error [ServerID: 4]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(56,	'e',	'Rcon Error [ServerID: 12]',	'Can&#39;t connect to RCON server: Cannot assign requested address',	'',	'',	1,	'10.0.0.5',	1643378255),
(57,	'm',	'Admin added',	'Admin (izaya) has been added.',	'',	'',	1,	'10.0.0.5',	1644821478),
(58,	'm',	'Group Updated',	'Group (normal admin) has been updated.',	'',	'',	1,	'10.0.0.5',	1644900776),
(59,	'm',	'Server Added',	'Server (bd.trygek.com:2333) has been added.',	'',	'',	1,	'10.0.0.5',	1644901104),
(60,	'm',	'Server Added',	'Server (bd.trygek.com:2334) has been added.',	'',	'',	1,	'10.0.0.5',	1644901123),
(61,	'm',	'Server Added',	'Server (bd.trygek.com:2335) has been added.',	'',	'',	1,	'10.0.0.5',	1644901139),
(62,	'm',	'Server Added',	'Server (bd.trygek.com:2336) has been added.',	'',	'',	1,	'10.0.0.5',	1644901157),
(63,	'm',	'Server Added',	'Server (gz.trygek.com:2337) has been added.',	'',	'',	1,	'10.0.0.5',	1644901187),
(64,	'm',	'Server Added',	'Server (gz.trygek.com:2338) has been added.',	'',	'',	1,	'10.0.0.5',	1644901202),
(65,	'm',	'Server Added',	'Server (gz.trygek.com:2339) has been added.',	'',	'',	1,	'10.0.0.5',	1644901217),
(66,	'm',	'Server Added',	'Server (gz.trygek.com:2340) has been added.',	'',	'',	1,	'10.0.0.5',	1644901236),
(67,	'm',	'Ban Added',	'Ban against (STEAM_0:1:236332239) has been added. Reason: Aimbot; Length: 0',	'',	'',	1,	'10.0.0.5',	1644976459),
(68,	'm',	'Player Unbanned',	'Aya (STEAM_1:0:432158669) has been unbanned.',	'',	'p=banlist&a=unban&id=6&key=444a8ab7a71ff8e0a530332188b53dd6&ureason=Mistakes',	1,	'10.0.0.5',	1645002920),
(69,	'm',	'Player Unbanned',	'麦氏环企鹅 (STEAM_1:1:452360485) has been unbanned.',	'',	'p=banlist&a=unban&id=10&key=f8f15c713b50ce8bf785b3b40c9709df&ureason=%E7%AC%AC%E4%B8%80%E6%AC%A1%E8%A7%A3%E9%99%A4ban&bulk=true',	1,	'10.0.0.5',	1645068311),
(70,	'm',	'Player Unbanned',	'赢不了摆烂了 (STEAM_1:1:615878492) has been unbanned.',	'',	'p=banlist&a=unban&id=8&key=f8f15c713b50ce8bf785b3b40c9709df&ureason=%E7%AC%AC%E4%B8%80%E6%AC%A1%E8%A7%A3%E9%99%A4ban',	1,	'10.0.0.5',	1645068319),
(71,	'm',	'Player Unbanned',	'沙包人 (STEAM_1:0:207406212) has been unbanned.',	'',	'p=banlist&a=unban&id=7&key=f8f15c713b50ce8bf785b3b40c9709df&ureason=%E7%AC%AC%E4%B8%80%E6%AC%A1%E8%A7%A3%E9%99%A4ban',	1,	'10.0.0.5',	1645068328),
(72,	'm',	'Ban Deleted',	'Ban tt (STEAM_0:0:97704553) has been deleted.',	'',	'p=banlist&a=delete&id=4&key=f8f15c713b50ce8bf785b3b40c9709df',	1,	'10.0.0.5',	1645073538),
(73,	'm',	'Ban Added',	'Ban against (STEAM_0:1:639850215) has been added. Reason: Aimbot; Length: 0',	'',	'',	1,	'10.0.0.5',	1645073568);

DROP TABLE IF EXISTS `sb_login_tokens`;
CREATE TABLE `sb_login_tokens` (
  `jti` varchar(16) NOT NULL,
  `secret` varchar(64) NOT NULL,
  `lastAccessed` int(11) NOT NULL,
  PRIMARY KEY (`jti`),
  UNIQUE KEY `secret` (`secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_login_tokens` (`jti`, `secret`, `lastAccessed`) VALUES
('4b3yaNO2OgN2or5s',	'4PfSVztE1IAaiypNLkB5supgz5yE6SyQg0C8UHRMmm7ISN6479ADWOOF0ioWFV8=',	1643259926),
('6mXW0fU2iC6Ajsr8',	'q3nSHHWe8KksoXfdWyw3dZGd4AhvGM8QMV5pgh8ZOHu9/XzxmhbH5nJDJAT0POQ=',	1645029904),
('AFDgtUc8i+ScbbA1',	'a2J6LAY0sHcZm1sKDHLoS45YvDeum2TvcM3o7YmDR6gKFIsI+UP9EyQg0WEgBDU=',	1644901238),
('BboobmxfWn3KsJTL',	'5vWaaF8GxLsyOeWDSRjhAAAuLlqG4cpiX0LSrKUtOih2dkEZtcyX0G9z0qzIpJ8=',	1643204179),
('D2gLR61AwhDEV9oo',	'M1ICxmsxmlYX+MhJmyYQOyzlhA/nRCLyfDhfMM4p4wv4gGoHmQDW7FQBd5ylLjg=',	1645026235),
('E/4qI5oA1X5i8BZC',	'mmYOUt10g6AlglTQisOlxZv2Bwhv6zC2gC/rjg30R1MPbsCw6KNBNnb1KLDzZVY=',	1643439729),
('Ex09vrOHueLBXiEk',	'fPHHukiU/qFQnfPwSuW1hvefsQdAYNB8InBCovbNC/k6QDEJR1mCKxO+QJVEC+k=',	1643433475),
('kL0NJpESorcc36Kp',	'HLpMO7EFHNNaqjsCgc1J3QQP28V6PkSnw8co24BCpvf3WX8PGyOX+Kiui787+cE=',	1644659053),
('SF1aWMoEjstBYwZH',	'ge6qnjcERDE8KTStgMKz36AucoP4LeRB8BpTe8apssh8/COA3IDGEq2MuZyuD6k=',	1645026420),
('UCl1PJDxPnUU02Bs',	'zNZr6jLkD64REeCkozAh2OQQBaOyWsCSrDVsK2hF53KlH+YRtz4SiLfeAXR8OPc=',	1645074374);

DROP TABLE IF EXISTS `sb_mods`;
CREATE TABLE `sb_mods` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `modfolder` varchar(64) NOT NULL,
  `steam_universe` tinyint(4) NOT NULL DEFAULT '0',
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mid`),
  UNIQUE KEY `modfolder` (`modfolder`),
  UNIQUE KEY `name` (`name`),
  KEY `steam_universe` (`steam_universe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_mods` (`mid`, `name`, `icon`, `modfolder`, `steam_universe`, `enabled`) VALUES
(0,	'Web',	'web.png',	'NULL',	0,	1),
(1,	'Half-Life 2 Deathmatch',	'hl2dm.png',	'hl2mp',	0,	1),
(2,	'Counter-Strike: Source',	'csource.png',	'cstrike',	0,	1),
(3,	'Day of Defeat: Source',	'dods.png',	'dod',	0,	1),
(4,	'Insurgency: Source',	'ins.png',	'insurgency',	0,	1),
(5,	'Dystopia',	'dys.png',	'dystopia_v1',	0,	1),
(6,	'Hidden: Source',	'hidden.png',	'hidden',	0,	1),
(7,	'Half-Life 2 Capture the Flag',	'hl2ctf.png',	'hl2ctf',	0,	1),
(8,	'Pirates Vikings and Knights II',	'pvkii.png',	'pvkii',	0,	1),
(9,	'Perfect Dark: Source',	'pdark.png',	'pdark',	0,	1),
(10,	'The Ship',	'ship.png',	'ship',	0,	1),
(11,	'Fortress Forever',	'hl2-fortressforever.png',	'FortressForever',	0,	1),
(12,	'Team Fortress 2',	'tf2.png',	'tf',	0,	1),
(13,	'Zombie Panic',	'zps.png',	'zps',	0,	1),
(14,	'Garry\'s Mod',	'gmod.png',	'garrysmod',	0,	1),
(15,	'Left 4 Dead',	'l4d.png',	'left4dead',	1,	1),
(16,	'Left 4 Dead 2',	'l4d2.png',	'left4dead2',	1,	1),
(17,	'CSPromod',	'cspromod.png',	'cspromod',	0,	1),
(18,	'Alien Swarm',	'alienswarm.png',	'alienswarm',	0,	1),
(19,	'E.Y.E: Divine Cybermancy',	'eye.png',	'eye',	0,	1),
(20,	'Nuclear Dawn',	'nucleardawn.png',	'nucleardawn',	0,	1),
(21,	'Counter-Strike: Global Offensive',	'csgo.png',	'csgo',	1,	1),
(22,	'Synergy',	'synergy.png',	'synergy',	0,	1);

DROP TABLE IF EXISTS `sb_overrides`;
CREATE TABLE `sb_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('command','group') NOT NULL,
  `name` varchar(32) NOT NULL,
  `flags` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_overrides` (`id`, `type`, `name`, `flags`) VALUES
(1,	'group',	'normal admin',	'gg');

DROP TABLE IF EXISTS `sb_protests`;
CREATE TABLE `sb_protests` (
  `pid` int(6) NOT NULL AUTO_INCREMENT,
  `bid` int(6) NOT NULL,
  `datesubmitted` int(11) NOT NULL,
  `reason` text NOT NULL,
  `email` varchar(128) NOT NULL,
  `archiv` tinyint(1) DEFAULT '0',
  `archivedby` int(11) DEFAULT NULL,
  `pip` varchar(64) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `bid` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_protests` (`pid`, `bid`, `datesubmitted`, `reason`, `email`, `archiv`, `archivedby`, `pip`) VALUES
(1,	6,	1644998386,	'emm我也很迷,我就打个1vht结果被认为是微自瞄???(aimbot)\r\n随意打打2特0秒,地图c2m2,到了大约第3波接特的地方(一般16秒刷特)子弹用完开始刀,因为新版本anne的hunter的扑人逻辑似乎更加复杂,在近处可能不会直接扑人而是侧向低飞再扑人骗刀,需要速砍和对ht位置的快速锁定以及时间的把控,......可能我就是因为反应太快就被认为自瞄?????我也不知道怎么解释,只是觉得挺离谱的..\r\n3000h里面我有接近2000h都是在玩anne,对ht的飞行轨迹基本已经形成了肌肉记忆\r\n1vht我没事的时候就会来练练,hunter party服伤害我也至少在30%以上,最高打过60%多.\r\n玩求生3000h不算长也不算短了,第一次被ban....\r\n可能是因为我的喷子风格?我比较偏向于甩喷,有时会直接在ht飞行轨迹处提前预瞄,场面混乱时候一本都是甩喷,鼠标dpi2800打求生的不多吧...\r\n望明鉴.谢谢',	'380352780@qq.com',	4,	NULL,	'171.213.52.6'),
(2,	9,	1645017190,	'[Little Anti-Cheat 1.7.1] Aimbot Detected\r\n\r\n玩鸟狙为什么会被封？？？？？？？？？？？？？？？？？？？？？？',	'1050040055@qq.com',	0,	NULL,	'49.70.91.106');

DROP TABLE IF EXISTS `sb_servers`;
CREATE TABLE `sb_servers` (
  `sid` int(6) NOT NULL AUTO_INCREMENT,
  `ip` varchar(64) NOT NULL,
  `port` int(5) NOT NULL,
  `rcon` varchar(64) NOT NULL,
  `modid` int(10) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `ip` (`ip`,`port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_servers` (`sid`, `ip`, `port`, `rcon`, `modid`, `enabled`) VALUES
(2,	'home.trygek.com',	2333,	'918899283',	16,	1),
(3,	'home.trygek.com',	2334,	'918899283',	16,	1),
(4,	'home.trygek.com',	2335,	'918899283',	16,	1),
(5,	'home.trygek.com',	2336,	'918899283',	16,	1),
(6,	'home.trygek.com',	2337,	'918899283',	16,	1),
(7,	'home.trygek.com',	2338,	'918899283',	16,	1),
(8,	'home.trygek.com',	2339,	'918899283',	16,	1),
(9,	'home.trygek.com',	2340,	'918899283',	16,	1),
(10,	'home.trygek.com',	2332,	'918899283',	16,	1),
(11,	'home.trygek.com',	2331,	'918899283',	16,	1),
(12,	'home.trygek.com',	2330,	'918899283',	16,	1),
(13,	'bd.trygek.com',	2333,	'918899283',	16,	1),
(14,	'bd.trygek.com',	2334,	'918899283',	16,	1),
(15,	'bd.trygek.com',	2335,	'918899283',	16,	1),
(16,	'bd.trygek.com',	2336,	'918899283',	16,	1),
(17,	'gz.trygek.com',	2337,	'918899283',	16,	1),
(18,	'gz.trygek.com',	2338,	'918899283',	16,	1),
(19,	'gz.trygek.com',	2339,	'918899283',	16,	1),
(20,	'gz.trygek.com',	2340,	'918899283',	16,	1);

DROP TABLE IF EXISTS `sb_servers_groups`;
CREATE TABLE `sb_servers_groups` (
  `server_id` int(10) NOT NULL,
  `group_id` int(10) NOT NULL,
  PRIMARY KEY (`server_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_settings`;
CREATE TABLE `sb_settings` (
  `setting` varchar(128) NOT NULL,
  `value` text NOT NULL,
  UNIQUE KEY `setting` (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_settings` (`setting`, `value`) VALUES
('auth.maxlife',	'1440'),
('auth.maxlife.remember',	'10080'),
('auth.maxlife.steam',	'10080'),
('banlist.bansperpage',	'30'),
('banlist.hideadminname',	'1'),
('banlist.hideplayerips',	'1'),
('banlist.nocountryfetch',	'1'),
('bans.customreasons',	''),
('config.dateformat',	'Y-m-d H:i:s'),
('config.debug',	'0 '),
('config.defaultpage',	'0'),
('config.enableadminrehashing',	'1'),
('config.enablecomms',	'1'),
('config.enablefriendsbanning',	'0'),
('config.enablegroupbanning',	'0'),
('config.enablekickit',	'1'),
('config.enableprotest',	'1'),
('config.enablepubliccomments',	'0'),
('config.enablesteamlogin',	'1'),
('config.enablesubmit',	'1'),
('config.exportpublic',	'0'),
('config.password.minlength',	'7'),
('config.theme',	'fluent'),
('config.version',	'702'),
('dash.intro.text',	'<center><p>Your new SourceBans install</p><p>SourceBans++ successfully installed!</center>'),
('dash.intro.title',	'Your SourceBans++ install'),
('dash.lognopopup',	'0'),
('protest.emailonlyinvolved',	'0'),
('template.logo',	'logos/sb-large.png'),
('template.title',	'SourceBans++');

DROP TABLE IF EXISTS `sb_srvgroups`;
CREATE TABLE `sb_srvgroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `flags` varchar(30) NOT NULL,
  `immunity` int(10) unsigned NOT NULL,
  `name` varchar(120) NOT NULL,
  `groups_immune` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sb_srvgroups` (`id`, `flags`, `immunity`, `name`, `groups_immune`) VALUES
(1,	'abcdghijklmz',	0,	'normal admin',	' ');

DROP TABLE IF EXISTS `sb_srvgroups_overrides`;
CREATE TABLE `sb_srvgroups_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` smallint(5) unsigned NOT NULL,
  `type` enum('command','group') NOT NULL,
  `name` varchar(32) NOT NULL,
  `access` enum('allow','deny') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `sb_submissions`;
CREATE TABLE `sb_submissions` (
  `subid` int(6) NOT NULL AUTO_INCREMENT,
  `submitted` int(11) NOT NULL,
  `ModID` int(6) NOT NULL,
  `SteamId` varchar(64) NOT NULL DEFAULT 'unnamed',
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `reason` text NOT NULL,
  `ip` varchar(64) NOT NULL,
  `subname` varchar(128) DEFAULT NULL,
  `sip` varchar(64) DEFAULT NULL,
  `archiv` tinyint(1) DEFAULT '0',
  `archivedby` int(11) DEFAULT NULL,
  `server` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`subid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2022-02-17 05:19:31
